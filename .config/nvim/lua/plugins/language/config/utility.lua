local util = require("util.language")

return {
    util.register_treesitter_languages({
        "diff",
        "git_rebase",
        "gitcommit",
        "http",
        "make",
        "query",
        "regex",
    }),
}
