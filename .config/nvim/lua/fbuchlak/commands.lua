vim.api.nvim_create_user_command("FBuchlakOpenGhRepo", function()
    local filepath = vim.api.nvim_eval("shellescape(expand('<cfile>'))")
    local path = filepath:sub(2, #filepath - 1)

    vim.fn.system({ "xdg-open", "https://github.com/" .. path })
end, { desc = "Open path under the cursor as github url" })
