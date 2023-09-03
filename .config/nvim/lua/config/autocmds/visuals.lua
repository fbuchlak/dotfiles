local create_autocmd = require("util").create_autocmd

create_autocmd("VimResized", "FixSplits", { command = [[wincmd =]] })

create_autocmd("TextYankPost", "Highlight", {
    callback = function()
        vim.highlight.on_yank()
    end,
})
