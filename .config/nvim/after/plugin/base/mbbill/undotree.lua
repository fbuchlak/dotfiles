require("which-key").register({
    u = {
        name = "Undotree",
        f = { "<CMD>UndotreeFocus<CR>", "Undotree Focus" },
        q = { "<CMD>UndotreeHide<CR>", "Undotree Hide" },
        t = { "<CMD>UndotreeToggle<CR>", "Undotree Toggle" },
        u = { "<CMD>UndotreeToggle<CR><CMD>UndotreeFocus<CR>", "Undotree Toggle & Focus" },
    },
}, { prefix = "<LocalLeader>" })
