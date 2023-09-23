local defaults = require("config.defaults")

local enabled = function()
    return vim.bo.buftype ~= "prompt" and vim.b.cmp_enabled ~= false
end

return {
    { "onsails/lspkind.nvim", lazy = true },
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = "InsertEnter",
        dependencies = {
            "andersevenrud/cmp-tmux",
            "chrisgrieser/cmp-nerdfont",
            "FelipeLema/cmp-async-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/nvim-cmp",
            "jcha0713/cmp-tw2css",
            "lukas-reineke/cmp-rg",
            "max397574/cmp-greek",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            local cmp = require("cmp")
            local lspCompletionItemKind = require("cmp.types").lsp.CompletionItemKind
            local window_defaults = cmp.config.window.bordered({ border = defaults.border })

            local cmp_sources = {
                {
                    name = "nvim_lsp",
                    entry_filter = function(entry)
                        return entry:get_kind() ~= lspCompletionItemKind.Snippet
                            and entry.source:get_debug_name() ~= "nvim_lsp:emmet_ls"
                    end,
                },
                { name = "nvim_lsp_signature_help" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "async_path" },
                { name = "calc" },
                { name = "greek" },
                { name = "emoji" },
                { name = "nerdfont" },
                { name = "tmux" },
                { name = "rg", keyword_length = 3 },
                { name = "cmp-tw2css", fallback = false },
            }

            local cmp_source_names = {
                luasnip = "",
                nvim_lsp = "[LSP]",
                nvim_lsp_signature_help = "[LSP Signature]",
                async_path = "[Filesystem]",
                ["cmp-tw2css"] = "[Tailwind > CSS]",
            }
            for _, source in pairs(cmp_sources) do
                if not cmp_source_names[source.name] then
                    cmp_source_names[source.name] = "[" .. (source.name:gsub("^%l", string.upper)) .. "]"
                end
            end

            return {
                enabled = enabled,
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = window_defaults,
                    documentation = window_defaults,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.SelectBehavior.Insert, select = true }),
                    ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                }),
                sources = cmp.config.sources(cmp_sources),
                experimental = {
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    },
                },
                sorting = require("cmp.config.default")().sorting,
                formatting = {
                    format = require("lspkind").cmp_format({
                        mode = "symbol_text",
                        menu = cmp_source_names,
                    }),
                },
            }
        end,
        config = function(_, opts)
            local cmp = require("cmp")

            cmp.setup(opts)

            local search_opts = {
                enabled = enabled,
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            }
            cmp.setup.cmdline({ "/", "?" }, search_opts)

            local cmd_opts = {
                enabled = enabled,
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "async_path" },
                    { name = "cmdline" },
                }),
            }
            cmp.setup.cmdline(":", cmd_opts)
        end,
    },
    require("util").plugin_disable_for_bigfile("hrsh7th/nvim-cmp", function()
        vim.b.cmp_enabled = false
    end),
}
