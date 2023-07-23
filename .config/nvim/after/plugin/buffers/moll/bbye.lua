require("which-key").register({
    q = { ":Bdelete<CR>", "[Buff] delete current" },
    Q = { ":bufdo :Bdelete<CR>", "[Buff] delete all" },
    w = {
        name = "Write",
        q = { ":w<CR>:Bdelete<CR>", "[Buff] write & delete current" },
        Q = { ":bufdo :w<CR>:bufdo :Bdelete<CR>", "[Buff] write & delete all" },
    },
}, { prefix = "<Leader>" })
