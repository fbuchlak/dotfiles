require("which-key").register({
    c = {
        name = "Colorizer",
        r = { "<CMD>ColorizerReloadAllBuffers<CR>", "Colorizer Reload" },
        t = { "<CMD>ColorizerToggle<CR>", "Colorizer Toggle" },
    },
}, { prefix = "<LocalLeader>" })
