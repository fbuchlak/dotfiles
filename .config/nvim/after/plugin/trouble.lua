local opts = { silent = true, noremap = true }

vim.keymap.set("n", "<leader>tt", "<cmd>TroubleToggle<cr>", opts)

vim.keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
vim.keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>", opts)
vim.keymap.set("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
