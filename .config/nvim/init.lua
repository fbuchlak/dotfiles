require("config")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    ui = {
        border = require("config.defaults").border,
    },
    spec = {
        { import = "plugins.editor" },
        { import = "plugins.language" },
        { import = "plugins.language.config" },
        { import = "plugins.navigation" },
        { import = "plugins.refactoring" },
        { import = "plugins.vcs" },
    },
    change_detection = { enabled = false },
})
