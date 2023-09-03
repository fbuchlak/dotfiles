local util = require("util")
local defaults = require("config.defaults")

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "folke/neoconf.nvim", cmd = "Neoconf", config = false },
            { "folke/neodev.nvim", opts = {} },
            { "kosayoda/nvim-lightbulb", opts = { autocmd = { enabled = true } } },
            "williamboman/mason-lspconfig.nvim",
        },
        opts = { ensure_installed = {} },
        config = function(_, opts)
            -- Config
            require("neoconf").setup({})

            -- Ui
            require("lspconfig.ui.windows").default_options = { border = defaults.border }

            -- Register keymaps
            local lsp_util = require("util.lsp")
            util.map("n", "<Leader>lr", "<CMD>LspRestart<CR>", { desc = "[LSP] Restart" })
                .map("n", "<Leader>li", "<CMD>LspInfo<CR>", { desc = "[LSP] Info" })
                .map("n", "<Leader>lwa", vim.lsp.buf.add_workspace_folder, { desc = "[LSP][Workspace] Add Folder" })
                .map("n", "<Leader>lwr", vim.lsp.buf.remove_workspace_folder, { desc = "[LSP][Workspace] Remove Folder" })
                .map("n", "<Leader>lwl", vim.lsp.buf.list_workspace_folders, { desc = "[LSP][Workspace] List Folders" })
                .map({ "n", "v" }, "<LocalLeader>ff", lsp_util.format, { desc = "Format" })
                .map({ "n", "v" }, "<LocalLeader>fw", function()
                    lsp_util.format()
                    vim.cmd("w")
                end, { desc = "Format and write" })
            lsp_util.on_attach(lsp_util.attach_keymaps)

            -- Server setup
            local servers = opts.servers or {}
            local servers_all = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package) or {}
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities() or {},
                opts.capabilities or {}
            )

            local function setup(server)
                require("lspconfig")[server].setup(vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {}))
            end

            local ensure_installed = {}
            for server, _ in pairs(servers) do
                if not vim.tbl_contains(servers_all, server) then
                    setup(server)
                else
                    ensure_installed[#ensure_installed + 1] = server
                end
            end

            require("mason-lspconfig").setup({ ensure_installed = ensure_installed, handlers = { setup } })
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {
            ui = {
                border = defaults.border,
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason.nvim" },
        opts = function()
            return {
                root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
                sources = {},
            }
        end,
    },
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
        opts = {
            text = { spinner = "clock" },
            window = { blend = 0 },
        },
    },
    {
        "folke/which-key.nvim",
        optional = true,
        opts = {
            defaults = {
                ["<Leader>l"] = { name = "[LSP]" },
                ["<Leader>lw"] = { name = "[LSP][Workspace]" },
                ["<Leader>g"] = { name = "[Action]" },
            },
        },
    },
}
