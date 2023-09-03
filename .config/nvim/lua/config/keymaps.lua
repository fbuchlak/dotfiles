local util = require("util")

local function create_toggle(options)
    return function()
        util.toggle(options)
    end
end

local function toggle_diagnostic()
    if vim.diagnostic.is_disabled() then
        vim.diagnostic.enable()
    else
        vim.diagnostic.disable()
    end
end

util
    -- base
    .map({ "n", "v", "i" }, "<C-s>", "<CMD>w<CR>")
    .map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
    .map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
    .map("n", "<C-b>", "<C-b>zz")
    .map("n", "<C-d>", "<C-d>zz")
    .map("n", "<C-f>", "<C-f>zz")
    .map("n", "<C-u>", "<C-u>zz")
    .map("x", "<Leader>p", [["_dP]])
    .map({ "n", "v" }, "<Leader>D", [["_D]])
    .map({ "n", "v" }, "<Leader>d", [["_d]])
    .map({ "n", "v" }, "<Leader>Y", [["+Y]])
    .map({ "n", "v" }, "<Leader>y", [["+y]])
    .map("n", "<LocalLeader>q", "<CMD>q<CR>")
    .map("n", "<LocalLeader>bs", "<CMD>w<CR><CMD>so %<CR>", { desc = "[Buf] Source Current" })
    -- toggle
    .map("n", "<LocalLeader>mc", create_toggle({ "cursorcolumn", "cursorline" }), { desc = "Toggle Cursor" })
    .map("n", "<LocalLeader>mn", create_toggle({ "number", "relativenumber" }), { desc = "Toggle Numbers" })
    .map("n", "<LocalLeader>ms", create_toggle("spell"), { desc = "Toggle Spell" })
    .map("n", "<LocalLeader>mh", create_toggle("hlsearch"), { desc = "Toggle Hightlight Search" })
    .map("n", "<LocalLeader>mw", create_toggle("wrap"), { desc = "Toggle Wrap" })
    .map("n", "<LocalLeader>md", toggle_diagnostic, { desc = "Toggle Disagnostic" })
    -- windows
    .map("n", "<C-Up>", "<CMD>resize +1<CR>")
    .map("n", "<C-Down>", "<CMD>resize -1<CR>")
    .map("n", "<C-Left>", "<CMD>vertical resize -1<CR>")
    .map("n", "<C-Right>", "<CMD>vertical resize +1<CR>")
    -- move lines
    .map("n", "<S-Down>", "<cmd>m .+1<cr>==", { desc = "Move down" })
    .map("n", "<S-Up>", "<cmd>m .-2<cr>==", { desc = "Move up" })
    .map("i", "<S-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
    .map("i", "<S-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
    .map("v", "<S-Down>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
    .map("v", "<S-Up>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
    -- insert breakpoints
    .map("i", ",", ",<c-g>u")
    .map("i", ".", ".<c-g>u")
    .map("i", ";", ";<c-g>u")
