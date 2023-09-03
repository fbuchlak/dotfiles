return {
    {
        "mbbill/undotree",
        keys = {
            {
                "<LocalLeader>u",
                "<CMD>UndotreeToggle<CR><CMD>UndotreeFocus<CR>",
                desc = "[Undotree] Toggle",
            },
        },
    },
    {
        "kevinhwang91/nvim-fundo",
        opts = {},
        dependencies = { "kevinhwang91/promise-async" },
        build = function()
            require("fundo").install()
        end,
    },
}
