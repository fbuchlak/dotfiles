require("which-key").register({
    t = {
        name = "Trouble",
        d = { "<CMD>TroubleToggle document_diagnostics<CR>", "Document" },
        f = { "<CMD>TroubleToggle quickfix<CR>", "Fix" },
        r = { "<CMD>TroubleRefresh<CR>", "Refresh" },
        t = { "<CMD>TroubleToggle<CR>", "Toggle" },
        w = { "<CMD>TroubleToggle workspace_diagnostics<CR>", "Workspace" },
    },
}, { prefix = "<LocalLeader>" })
