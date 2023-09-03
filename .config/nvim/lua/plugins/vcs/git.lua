local util = require("util")

return {
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").load_extension("lazygit")
            util.create_autocmd("BufEnter", "LazyGit", {
                pattern = "*",
                callback = function()
                    require("lazygit.utils").project_root_dir()
                end,
            })
        end,
        keys = {
            {
                "<LocalLeader>gg",
                function()
                    require("telescope").extensions.lazygit.lazygit()
                end,
                desc = "[Search] LazyGit Repositories",
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "?" },
            },
            on_attach = function()
                local gs = require("gitsigns")
                local next_hunk_repeat, prev_hunk_repeat =
                    require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair(
                        gs.next_hunk,
                        gs.prev_hunk
                    )

                util.map("n", "<Leader>hg", gs.preview_hunk_inline, { desc = "[Git] Show Hunk Inline" })
                    .map("n", "<Leader>jg", next_hunk_repeat, { desc = "[Jump Next][Git] Hunk" })
                    .map("n", "<Leader>kg", prev_hunk_repeat, { desc = "[Jump Prev][Git] Hunk" })
                    .map("n", "<LocalLeader>gb", gs.toggle_current_line_blame, { desc = "[Git] Toggle Line Blame" })
                    .map("n", "<LocalLeader>gd", gs.diffthis, { desc = "[Git] Diff" })
                    .map("n", "<LocalLeader>gw", gs.toggle_word_diff, { desc = "[Git] Toggle Word Diff" })
            end,
        },
    },
    {
        "folke/which-key.nvim",
        optional = true,
        opts = {
            defaults = {
                ["<LocalLeader>g"] = { name = "[Git]" },
            },
        },
    },
}
