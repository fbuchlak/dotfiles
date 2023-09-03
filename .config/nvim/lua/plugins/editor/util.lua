local defaults = require("config.defaults")

return {
    { "nvim-lua/plenary.nvim", lazy = true },
    { "tpope/vim-abolish", event = "VeryLazy" },
    { "tpope/vim-repeat", event = "VeryLazy" },
    {
        "echasnovski/mini.surround",
        version = "*",
        keys = {
            { "gs", "<Nop>" },
        },
        opts = {
            mappings = {
                add = "gsa",
                delete = "gsd",
                find = "gsf",
                find_left = "gsF",
                highlight = "gsh",
                replace = "gsr",
                update_n_lines = "gsn",
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            {
                "ahmedkhalf/project.nvim",
                opts = {},
                event = "VeryLazy",
                config = function(_, opts)
                    require("project_nvim").setup(opts)
                    require("telescope").load_extension("projects")
                end,
                keys = {
                    { "<leader>gg", "<Cmd>Telescope projects<CR>", desc = "Projects" },
                },
            },
        },
    },
    {
        "rmagatti/auto-session",
        opts = {
            log_level = "error",
            auto_session_suppress_dirs = { "~/", "~/git", "~/Downloads", "/" },
            auto_session_use_git_branch = true,
        },
    },
    { "rest-nvim/rest.nvim", opts = {} },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            window = { border = defaults.border },
            defaults = {
                mode = { "n" },
                ["<Leader>h"] = { name = "[Show]" },
                ["<Leader>j"] = { name = "[Jump Next]" },
                ["<Leader>js"] = { name = "[Swap Next]" },
                ["<Leader>k"] = { name = "[Jump Prev]" },
                ["<Leader>ks"] = { name = "[Swap Prev]" },
                ["<LocalLeader>f"] = { name = "[Format]" },
                ["<LocalLeader>m"] = { name = "[Toggle]" },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")

            wk.setup(opts)
            wk.register(opts.defaults)
        end,
    },
}
