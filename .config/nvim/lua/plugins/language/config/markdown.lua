local util = require("util.language")

return {
    {
        "ellisonleao/glow.nvim",
        cmd = "Glow",
        config = {
            border = require("config.defaults").border,
        },
    },
    util.register_treesitter_languages({ "markdown", "markdown_inline" }),
}
