return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            { "hrsh7th/vim-vsnip", dependencies = { "hrsh7th/vim-vsnip-integ" } },
            {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                    require("luasnip.loaders.from_snipmate").lazy_load()
                end,
            },
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        keys = {
            -- stylua: ignore start
            { "<Tab>", function() return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>" end, expr = true, silent = true, mode = "i", },
            { "<Tab>", function() require("luasnip").jump(1) end, mode = "s", },
            { "<S-Tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" }, },
            { "<C-E>", function() local ls = require("luasnip") if ls.choice_active() then ls.change_choice(1) end end, mode = { "i", "s" }, },
            -- stylua: ignore end
        },
    },
}
