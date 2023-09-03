local util = require("util.language")

local djlint_opts = {
    filetypes = {
        "django",
        "htmldjango",
        "jinja.html",
        "ninja",
        "twig",
    },
}

return {
    "jwalton512/vim-blade",
    util.register_treesitter_languages({ "htmldjango", "twig", "ninja" }),
    util.register_mason({ "blade-formatter", "djlint" }),
    util.configure_null_ls(function(_, opts)
        local nls = require("null-ls")
        opts.sources = opts.sources or {}
        vim.list_extend(opts.sources, {
            nls.builtins.formatting.blade_formatter,
            nls.builtins.formatting.djlint.with(djlint_opts),
            nls.builtins.diagnostics.djlint.with(djlint_opts),
        })
    end),
}
