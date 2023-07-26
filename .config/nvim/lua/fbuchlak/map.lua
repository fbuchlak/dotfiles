local set = vim.keymap.set

set("i", "jk", "<ESC>")
set({ "n", "i" }, "<C-s>", "<CMD>w<CR>")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "Q", "<nop>")

set("n", "<Leader>Y", [["+Y]])
set({ "n", "v" }, "<Leader>y", [["+y]])
set({ "n", "v" }, "<Leader>d", [["_d]])

set("x", "<Leader>p", [["_dP]])

set("n", "<LocalLeader>f", "<CMD>Format<CR>")
set("n", "<LocalLeader>q", "<CMD>q<CR>")

set("n", "gX", "<CMD>FBuchlakOpenGhRepo<CR>")
