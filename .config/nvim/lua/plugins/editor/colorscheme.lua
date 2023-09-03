return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function(_, opts)
            require("catppuccin").setup(opts)

            vim.cmd.colorscheme("catppuccin")
        end,
        opts = {
            flavour = "macchiato",
            transparent_background = true,
            dim_inactive = { enabled = false },
            integrations = {
                cmp = true,
                gitsigns = true,
                illuminate = true,
                indent_blankline = { enabled = true, colored_indent_levels = false },
                lsp_trouble = true,
                mason = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                which_key = true,
            },
        },
    },
}
