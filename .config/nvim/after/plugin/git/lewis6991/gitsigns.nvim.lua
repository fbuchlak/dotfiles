local gs = require("gitsigns")

local on_attach = function()
    require("which-key").register({
        g = {
            name = "Git",
            b = { gs.toggle_current_line_blame, "Toggle Line Blame" },
            d = { gs.diffthis, "Diff this" },
            n = { gs.next_hunk, "Next Hunk" },
            p = { gs.prev_hunk, "Prev Hunk" },
            w = { gs.toggle_word_diff, "Toggle Word Diff" },
        },
    }, { prefix = "<LocalLeader>" })
end

gs.setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "?" },
    },
    on_attach = on_attach,
})
