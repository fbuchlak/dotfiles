local lsp_config = require("mason-lspconfig")

local servers = require("fbuchlak.lsp.servers")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local on_attach = function(_, buffer)
    local l = vim.lsp.buf
    local t = require("telescope.builtin")

    local wk = require("which-key")

    wk.register({
        a = { l.code_action, "LSP Code Action" },
        D = { l.declaration, "LSP Declaration" },
        d = { l.definition, "LSP Definiton" },
        I = { l.implementation, "LSP Implementation" },
        r = { l.references, "LSP References" },
        R = { l.rename, "LSP Rename" },
    }, { prefix = "g", buffer = buffer })

    wk.register({
        ["<C-k>"] = { l.signature_help, "LSP Signature Help" },
    }, { buffer = buffer })

    wk.register({
        K = { l.hover, "LSP Hover" },
    }, { buffer = buffer })

    wk.register({
        f = {
            l = {
                name = "Find LSP",
                d = { t.lsp_definitions, "Find LSP Definition" },
                i = { t.lsp_implementations, "Find LSP Implementation" },
                r = { t.lsp_references, "Find LSP Reference" },
                s = { t.lsp_document_symbols, "Find LSP Document Symbol" },
                w = { t.lsp_dynamic_workspace_symbols, "Find LSP Workspace Symbol" },
            },
        },
        l = {
            name = "LSP",
            i = { "<CMD>LspInfo<CR>", "LSP Info" },
            r = { "<CMD>LspRestart<CR>", "LSP Restart" },
            w = {
                name = "LSP Workspace",
                a = { l.add_workspace_folder, "LSP Workspace Add" },
                l = {
                    function()
                        local popup = require("plenary.popup")
                        local win = popup.create(l.list_workspace_folders(), {
                            border = true,
                        })
                        print(win)
                    end,
                    "LSP Workspace List",
                },
                r = { l.remove_workspace_folder, "LSP Workspace Remove" },
            },
        },
    }, { prefix = "<Leader>", buffer = buffer })

    vim.api.nvim_buf_create_user_command(buffer, "Format", function(_)
        l.format()
    end, { desc = "Format current buffer with LSP" })
end

lsp_config.setup({
    ensure_installed = vim.tbl_keys(servers),
})

lsp_config.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        })
    end,
})
