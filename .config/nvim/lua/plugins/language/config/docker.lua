local util = require("util.language")

return {
    util.register_treesitter_languages({ "dockerfile" }),
    util.register_lsp_servers({
        dockerls = {},
        docker_compose_language_service = {},
    }),
    util.register_mason({ "hadolint" }),
    util.configure_null_ls(function(_, opts)
        local null_ls = require("null-ls")

        opts.sources = opts.sources or {}
        vim.list_extend(opts.sources, {
            null_ls.builtins.diagnostics.hadolint,
        })
    end),
}
