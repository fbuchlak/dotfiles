return {
    {
        "nvim-pack/nvim-spectre",
        cmd = "Spectre",
        opts = { open_cmd = "noswapfile vnew" },
        keys = {
            -- stylua: ignore start
            { "<LocalLeader>ss", function() require("spectre").toggle() end, desc = "[Spectre] Toggle", },
            { "<LocalLeader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "[Spectre] Search Current Word", },
            { "<LocalLeader>sf", function() require("spectre").open_file_search({ select_word = true }) end, desc = "[Spectre] Search Current File", },
            -- stylua: ignore end
        },
    },
    {
        "folke/which-key.nvim",
        optional = true,
        opts = {
            defaults = {
                ["<LocalLeader>s"] = { name = "[Spectre]" },
            },
        },
    },
}
