require("util")
    .create_autocmd("FileType", "CloseWithQ", {
        callback = function(e)
            vim.bo[e.buf].buflisted = false
            vim.keymap.set("n", "q", "<CMD>q<CR>", {
                buffer = e.buf,
                silent = true,
            })
        end,
        pattern = {
            "checkhealth",
            "help",
            "lspinfo",
            "man",
            "PlenaryTestPopup",
            "spectre_panel",
        },
    })
    .create_autocmd("FileType", "SpellWrapOn", {
        pattern = { "gitcommit", "markdown" },
        callback = function()
            vim.opt_local.spell = true
            vim.opt_local.wrap = true
        end,
    })
