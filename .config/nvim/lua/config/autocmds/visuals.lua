require("util")
    .create_autocmd("VimResized", "FixSplits", { command = [[wincmd =]] })
    .create_autocmd("TextYankPost", "Highlight", {
        callback = function()
            vim.highlight.on_yank()
        end,
    })
