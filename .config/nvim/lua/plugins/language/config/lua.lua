local util = require("util.language")

return {
    util.register_treesitter_languages({ "lua", "luadoc", "luap" }),
    util.register_lsp_servers({
        lua_ls = {
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        },
    }),
    util.register_mason({ "stylua" }),
    util.configure_null_ls(function(_, opts)
        local nls = require("null-ls")
        opts.sources = opts.sources or {}
        vim.list_extend(opts.sources, {
            nls.builtins.formatting.stylua,
        })
    end),
}
