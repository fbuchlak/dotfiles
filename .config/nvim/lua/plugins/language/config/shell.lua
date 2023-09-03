local util = require("util.language")

return {
    util.register_treesitter_languages({ "bash", "fish" }),
    util.register_lsp_servers({ bashls = {} }),
    util.register_mason({ "beautysh", "shellcheck" }),
    util.configure_null_ls(function(_, opts)
        local null_ls = require("null-ls")
        opts.sources = opts.sources or {}
        vim.list_extend(opts.sources, {
            null_ls.builtins.formatting.beautysh,
            null_ls.builtins.code_actions.shellcheck,
            null_ls.builtins.diagnostics.shellcheck,
        })
    end),
}
