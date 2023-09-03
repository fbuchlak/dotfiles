return {
    {
        "hrsh7th/vim-vsnip",
        dependencies = {
            "hrsh7th/vim-vsnip-integ",
            -- vscode
            "h4kst3r/php-awesome-snippets",
            "nalabdou/symfony-code-snippets",
            "nalabdou/twig-code-snippets",
        },
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            {
                "<tab>",
                function()
                    require("luasnip").jump(1)
                end,
                mode = "s",
            },
            {
                "<s-tab>",
                function()
                    require("luasnip").jump(-1)
                end,
                mode = { "i", "s" },
            },
            {
                "<C-E>",
                function()
                    local ls = require("luasnip")
                    if ls.choice_active() then
                        ls.change_choice(1)
                    end
                end,
                mode = { "i", "s" },
            },
        },
    },
}
