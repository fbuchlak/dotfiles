local util = require("util.language")

return {
    util.register_treesitter_languages({ "python" }),
    util.register_lsp_servers({ pyright = {} }),
    util.register_mason({ "black" }),
    util.configure_null_ls(function(_, opts)
        local nls = require("null-ls")
        opts.sources = opts.sources or {}
        vim.list_extend(opts.sources, {
            nls.builtins.formatting.black,
        })
    end),
}
