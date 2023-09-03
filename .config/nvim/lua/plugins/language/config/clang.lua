local util = require("util.language")

return {
    util.register_treesitter_languages({ "c", "cpp" }),
    util.register_lsp_servers({
        clangd = {},
    }),
}
