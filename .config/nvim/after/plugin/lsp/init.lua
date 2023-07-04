local ts = require("telescope.builtin")

local on_attach = function(_, buffer)
    local nmap = function(keys, func)
        vim.keymap.set("n", keys, func, { buffer = buffer })
    end

    local lbuf = vim.lsp.buf

    nmap("<leader>rn", lbuf.rename)
    nmap("<leader>ca", lbuf.code_action)

    nmap("gd", lbuf.definition)
    nmap("gr", ts.lsp_references)
    nmap("gI", lbuf.implementation)
    nmap("<leader>D", lbuf.type_definition)
    nmap("<leader>ds", ts.lsp_document_symbols)
    nmap("<leader>ws", ts.lsp_dynamic_workspace_symbols)

    nmap("K", lbuf.hover)
    nmap("<C-k>", lbuf.signature_help)

    nmap("gD", lbuf.declaration)
    nmap("<leader>wa", lbuf.add_workspace_folder)
    nmap("<leader>wr", lbuf.remove_workspace_folder)
    nmap("<leader>wl", function()
        print(vim.inspect(lbuf.list_workspace_folders()))
    end)

    vim.api.nvim_buf_create_user_command(buffer, "Format", function(_)
        lbuf.format()
    end, { desc = "Format current buffer with LSP" })
end

local servers = {
    awk_ls = {},
    bashls = {},
    clangd = {},
    cssls = {},
    emmet_ls = {},
    gopls = {},
    html = {},
    intelephense = {},
    jsonls = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim" } },
        },
    },
    tailwindcss = {},
    taplo = {},
    tsserver = {},
}

require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        })
    end,
})

local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
})
