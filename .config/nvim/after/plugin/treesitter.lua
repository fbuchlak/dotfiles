require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "cpp", "go", "lua", "php", "rust", "tsx", "typescript", "vimdoc", "vim" },
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<M-space>",
        },
    },
})
