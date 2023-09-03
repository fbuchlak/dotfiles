return {
    "tpope/vim-sleuth",
    {
        "johmsalas/text-case.nvim",
        opts = {},
        keys = {
            { "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "[Change Case] Telescope" }, mode = { "n", "v" } },
        },
        config = function(_, opts)
            require("textcase").setup(opts)
            require("telescope").load_extension("textcase")
        end,
    },
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<Leader>st", "<CMD>TodoTelescope<CR>", desc = "[Search] Todo comments" },
        },
        config = function(_, opts)
            local tc = require("todo-comments")

            local todo_next, todo_prev =
                require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair(
                    tc.jump_next,
                    tc.jump_prev
                )

            require("util")
                .map("n", "<Leader>jt", todo_next, { desc = "[Jump Next] Todo" })
                .map("n", "<Leader>kt", todo_prev, { desc = "[Jump Prev] Todo" })

            tc.setup(opts)
        end,
        opts = {
            highlight = { pattern = [[.*<(KEYWORDS)\s*]] },
            search = { pattern = [[\b(KEYWORDS)\b]] },
        },
    },
    {
        "Wansmer/treesj",
        cmd = { "TSJJoin", "TSJSplit", "TSJToggle" },
        opts = {
            use_default_keymaps = false,
            max_join_length = 110,
        },
        keys = {
            { "gG", "<CMD>TSJToggle<CR>", "[TreeSitter] Join/Split Object" },
            { "gJ", "<CMD>TSJJoin<CR>", "[TreeSitter] Join Object" },
            { "gS", "<CMD>TSJSplit<CR>", "[TreeSitter] Split Object" },
        },
    },
    { "numToStr/Comment.nvim", opts = {} },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function(_, opts)
            local hl = require("nvim-highlight-colors")
            require("util").map("n", "<LocalLeader>mC", hl.toggle, { desc = "Toggle Highlight Colors" })
            hl.setup(opts)
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        opts = {
            char = "|",
            show_current_context = true,
            show_current_context_start = false,
            show_end_of_line = true,
            show_trailing_blankline_indent = true,
            space_char_blankline = " ",
            filetype_exclude = {
                "help",
                "Trouble",
                "lazy",
                "mason",
                "notify",
            },
        },
    },
    {
        "folke/which-key.nvim",
        optional = true,
        opts = {
            defaults = {
                ["<Leader>w"] = { name = "[Buf] write" },
                ["<Leader>ww"] = { ":w<CR>", "[Buf] write" },
                ["<Leader>wW"] = { ":wa<CR>", "[Buf] write all" },
                ["<LocalLeader>b"] = { name = "[Buf]" },
                ["<LocalLeader>bq"] = { name = "[Buf] Close" },
            },
        },
    },
}
