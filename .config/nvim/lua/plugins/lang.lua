return {
    { "folke/neodev.nvim", opts = {} },
    { "folke/trouble.nvim", opts = {} },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            { "williamboman/mason.nvim", config = true },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "David-Kunz/cmp-npm",
            "FelipeLema/cmp-async-path",
            "L3MON4D3/LuaSnip",
            "andersevenrud/cmp-tmux",
            "chrisgrieser/cmp-nerdfont",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/nvim-cmp",
            "neovim/nvim-lspconfig",
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
        },
    },
    "nvim-telescope/telescope.nvim",
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
            return vim.fn.executable("make") == 1
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        build = ":TSUpdate",
    },
}
