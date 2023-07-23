return {
    {
        "folke/todo-comments.nvim",
        opts = {
            highlight = { pattern = [[.*<(KEYWORDS)\s*]] },
            search = { pattern = [[\b(KEYWORDS)\b]] },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {
            window = { border = "rounded" },
        },
    },
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
        opts = {
            text = { spinner = "clock" },
            window = { blend = 0 },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            char = "┊",
            show_trailing_blankline_indent = false,
            show_end_of_line = true,
        },
    },
    { "norcalli/nvim-colorizer.lua", opts = {} },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "catppuccin",
            },
        },
    },
    "nvim-tree/nvim-web-devicons",
}
