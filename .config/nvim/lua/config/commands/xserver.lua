local map = require("util").map

local open_gh = "XdgOpenGithubRepository"
vim.api.nvim_create_user_command(open_gh, function()
    local filepath = vim.api.nvim_eval("shellescape(expand('<cfile>'))")
    local path = filepath:sub(2, #filepath - 1)
    local url = (path:match("http://") or path:match("https://")) and path or "https://github.com/" .. path

    vim.fn.system({ "xdg-open", url })
end, {})
map("n", "gX", "<CMD>" .. open_gh .. "<CR>", {
    desc = "Open cfile path as github url",
})
