return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
            "folke/neodev.nvim",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-emoji",
            "rafamadriz/friendly-snippets",
            "Saecki/crates.nvim",
            "amarakon/nvim-cmp-fonts",
            "David-Kunz/cmp-npm",
            "f3fora/cmp-spell",
        },
    },
}
