local util = require("util")
local defaults = require("config.defaults")

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
            current_line_blame = true,
            preview_config = { border = defaults.border },
            on_attach = function()
                local gs = require("gitsigns")
                local next_hunk_repeat, prev_hunk_repeat =
                    require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair(
                        gs.next_hunk,
                        gs.prev_hunk
                    )

                util
                    -- Actions
                    .map("n", "<Leader>hg", gs.preview_hunk, { desc = "[Git] Show Hunk" })
                    .map("n", "<Leader>jg", next_hunk_repeat, { desc = "[Jump Next][Git] Hunk" })
                    .map("n", "<Leader>kg", prev_hunk_repeat, { desc = "[Jump Prev][Git] Hunk" })
                    .map("n", "<LocalLeader>gd", gs.diffthis, { desc = "[Git] Diff" })
                    .map("n", "<LocalLeader>gR", gs.reset_buffer, { desc = "[Git] Reset Buffer" })
                    .map("n", "<LocalLeader>gr", gs.reset_hunk, { desc = "[Git] Reset Hunk" })
                    .map("n", "<LocalLeader>gS", gs.stage_buffer, { desc = "[Git] Stage Buffer" })
                    .map("n", "<LocalLeader>gs", gs.stage_hunk, { desc = "[Git] Stage Hunk" })
                    .map("n", "<LocalLeader>gu", gs.undo_stage_hunk, { desc = "[Git] Undo Stage Hunk" })
                    .map("n", "<LocalLeader>gw", gs.toggle_word_diff, { desc = "[Git] Toggle Word Diff" })
                    -- Toggle
                    .map("n", "<LocalLeader>gtb", gs.toggle_current_line_blame, { desc = "[Git][Toggle] Line Blame" })
                    .map("n", "<LocalLeader>gtd", gs.toggle_deleted, { desc = "[Git][Toggle] Deleted" })
                    -- Text object
                    .map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end,
        },
    },
    {
        "folke/which-key.nvim",
        optional = true,
        opts = {
            defaults = {
                ["<LocalLeader>g"] = { name = "[Git]" },
                ["<LocalLeader>gt"] = { name = "[Git][Toggle]" },
            },
        },
    },
}
