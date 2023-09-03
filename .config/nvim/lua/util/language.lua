local M = {}

M.register_treesitter_languages = function(languages)
    return {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, languages)
            end
        end,
    }
end

M.register_lsp_servers = function(servers)
    return { "neovim/nvim-lspconfig", opts = { servers = servers } }
end

M.register_mason = function(ensure_installed)
    return {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, ensure_installed)
        end,
    }
end

M.configure_null_ls = function(opts)
    return { "jose-elias-alvarez/null-ls.nvim", opts = opts }
end

return M
