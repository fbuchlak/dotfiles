return {
    {
        "folke/which-key.nvim",
        optional = true,
        opts = {
            defaults = {
                ["<LocalLeader>r"] = { name = "[Refactor]", mode = { "n", "x" } },
                ["<LocalLeader>re"] = { name = "[Refactor] Extract", mode = { "n", "x" } },
            },
        },
    },
    {
        "ThePrimeagen/refactoring.nvim",
        keys = {
            {
                "<LocalLeader>ri",
                "<CMD>Refactor inline_var<CR>",
                desc = "[Refactor] Inline Var",
                mode = { "n", "x" },
            },
            {
                "<LocalLeader>reb",
                "<CMD>Refactor extract_var<CR>",
                desc = "[Refactor] Extract Block",
                mode = "n",
            },
            {
                "<LocalLeader>ree",
                "<CMD>Refactor extract<CR>",
                desc = "[Refactor] Extract",
                mode = "x",
            },
            {
                "<LocalLeader>rev",
                "<CMD>Refactor extract_var<CR>",
                desc = "[Refactor] Extract Variable",
                mode = "x",
            },
        },
        opts = {},
    },
}
