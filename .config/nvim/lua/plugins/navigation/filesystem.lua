local util = require("util")
local defaults = require("config.defaults")

return {
    {
        "folke/which-key.nvim",
        optional = true,
        opts = {
            defaults = {
                ["<Leader>e"] = { name = "[MiniFiles]" },
            },
        },
    },
    {
        "echasnovski/mini.files",
        version = "*",
        keys = {
            {
                "<Leader>ee",
                function()
                    local mf = require("mini.files")

                    if not mf.close() then
                        mf.open()
                    end
                end,
                desc = "[MiniFiles] Toggle",
            },
            {
                "<Leader>er",
                function()
                    require("mini.files").open(vim.api.nvim_buf_get_name(0))
                end,
                desc = "[MiniFiles] Reveal",
            },
        },
        opts = {
            options = {
                use_as_default_explorer = true,
            },
            mappings = {
                go_out_plus = "",
                go_out = "h",
                go_in = "",
                go_in_plus = "l",
            },
            windows = {
                preview = true,
                width_focus = 50,
                width_no_focus = 10,
                width_preview = 75,
            },
        },
        config = function(_, opts)
            util
                --
                .create_autocmd("User", "MiniFilesWindowOpen", {
                    pattern = "MiniFilesWindowOpen",
                    callback = function(args)
                        vim.api.nvim_win_set_config(args.data.win_id, { border = defaults.border })
                    end,
                })
                .create_autocmd("User", "MiniFilesBindings", {
                    pattern = "MiniFilesBufferCreate",
                    callback = function(args)
                        local bufnr = args.data.buf_id

                        util.map({ "n", "i", "v" }, "<C-s>", require("mini.files").synchronize, { buffer = bufnr })
                            .map("n", "<ESC>", require("mini.files").close, { buffer = bufnr })
                    end,
                })
                .create_autocmd("User", "MiniFilesStopTreesitterForBigFile", {
                    pattern = "MiniFilesBufferUpdate",
                    callback = function(args)
                        local bufnr = args.data.buf_id

                        if vim.api.nvim_buf_is_loaded(bufnr) then
                            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
                            for _, line in pairs(lines) do
                                if #line > 5000 then
                                    vim.treesitter.stop(bufnr)
                                    vim.bo[bufnr].syntax = nil

                                    break
                                end
                            end
                        end
                    end,
                })

            require("mini.files").setup(opts)
        end,
    },
}
