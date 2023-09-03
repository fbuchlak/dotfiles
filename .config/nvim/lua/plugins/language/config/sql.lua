local util = require("util.language")

local sqlfluff_args = { extra_args = { "--dialect", "mysql" } }

return {
    util.register_treesitter_languages({ "sql" }),
    util.register_lsp_servers({ sqlls = {} }),
    util.register_mason({ "sqlfluff" }),
    util.configure_null_ls(function(_, opts)
        local nls = require("null-ls")
        opts.sources = opts.sources or {}
        vim.list_extend(opts.sources, {
            nls.builtins.formatting.sqlfluff.with(sqlfluff_args),
            nls.builtins.diagnostics.sqlfluff.with(sqlfluff_args),
        })
    end),
}
