return {
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "nvim-lualine/lualine.nvim", opts = {} },
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            modes_allowlist = { "n" },
            min_count_to_highlight = 2,
            large_file_cutoff = 1500,
            large_file_overrides = { providers = { "lsp" } },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
        end,
    },
}
