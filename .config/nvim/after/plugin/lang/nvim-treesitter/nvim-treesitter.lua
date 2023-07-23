require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c",
        "cpp",
        "go",
        "lua",
        "php",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
    },
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
        },
    },
})
