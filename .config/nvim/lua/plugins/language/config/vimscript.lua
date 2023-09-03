local util = require("util.language")

return {
    util.register_treesitter_languages({ "vim", "vimdoc" }),
    util.register_lsp_servers({
        vimls = {},
    }),
    util.register_mason({ "vint" }),
    util.configure_null_ls(function(_, opts)
        local nls = require("null-ls")
        opts.sources = opts.sources or {}
        vim.list_extend(opts.sources, {
            nls.builtins.diagnostics.vint,
        })
    end),
}
