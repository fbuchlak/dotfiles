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

set("n", "<F7>", "<CMD>bprevious<CR>")
set("n", "<F8>", "<CMD>bnext<CR>")
set("n", "H", "<CMD>bprevious<CR>")
set("n", "L", "<CMD>bnext<CR>")

set("n", "gX", "<CMD>FBuchlakOpenGhRepo<CR>")
