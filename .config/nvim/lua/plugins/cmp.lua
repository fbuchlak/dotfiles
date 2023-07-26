return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "andersevenrud/cmp-tmux",
            "chrisgrieser/cmp-nerdfont",
            {
                "David-Kunz/cmp-npm",
                ft = "json",
                config = function()
                    require("cmp-npm").setup({})
                end,
            },
            "FelipeLema/cmp-async-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "lukas-reineke/cmp-rg",
            "neovim/nvim-lspconfig",
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
            {
                "saecki/crates.nvim",
                event = { "BufRead Cargo.toml" },
                config = function()
                    require("crates").setup({})
                end,
            },
        },
    },
}
