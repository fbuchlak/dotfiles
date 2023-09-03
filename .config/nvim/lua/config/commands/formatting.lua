local map = require("util").map

local remove_trailing = "RemoveTrailingWhitespaces"
vim.api.nvim_create_user_command(remove_trailing, function()
    vim.cmd([[%s/\s\+$//e]])
end, {})
map("n", "<LocalLeader>fs", "<CMD>" .. remove_trailing .. "<CR>", {
    desc = "Remove trailing white space",
})
