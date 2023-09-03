return {
    {
        "folke/which-key.nvim",
        optional = true,
        opts = {
            defaults = {
                ["<Leader>w"] = { name = "[Buf] write" },
                ["<Leader>ww"] = { ":w<CR>", "[Buf] write" },
                ["<Leader>wW"] = { ":wa<CR>", "[Buf] write all" },
                ["<LocalLeader>b"] = { name = "[Buf]" },
                ["<LocalLeader>bq"] = { name = "[Buf] Close" },
            },
        },
    },
    {
        "moll/vim-bbye",
        keys = {
            { "<Leader>Q", ":bufdo :Bdelete<CR>", desc = "[Buf] delete all" },
            { "<Leader>q", "<CMD>Bdelete<CR>", desc = "[Buf] delete current" },
            { "<Leader>wQ", ":bufdo :w<CR>:bufdo :Bdelete<CR>", desc = "[Buf] write & delete all" },
            { "<Leader>wq", ":w<CR>:Bdelete<CR>", desc = "[Buf] write & delete current" },
        },
    },
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
            { "<F7>", "<CMD>BufferLineMovePrev<CR>" },
            { "<F8>", "<CMD>BufferLineMoveNext<CR>" },
            { "H", "<CMD>BufferLineCyclePrev<CR>zz" },
            { "L", "<CMD>BufferLineCycleNext<CR>zz" },
            { "<LocalLeader>bql", "<CMD>BufferLineCloseLeft<CR>", "[Buf] Close Left" },
            { "<LocalLeader>bqq", "<CMD>BufferLineCloseOthers<CR>", "[Buf] Close Others" },
            { "<LocalLeader>bqr", "<CMD>BufferLineCloseRight<CR>", "[Buf] Close Right" },
        },
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                close_icon = "",
                buffer_close_icon = "",
                offsets = {
                    {
                        filetype = "spectre_panel",
                        text = "Search and replace",
                        text_align = "left",
                        separator = true,
                    },
                },
            },
        },
    },
}
