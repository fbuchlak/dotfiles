local k = vim.keymap
local ts = require("telescope")
local tsb = require("telescope.builtin")

pcall(ts.load_extension, "fzf")

k.set("n", "<leader>e", tsb.oldfiles)
k.set("n", "<leader><space>", tsb.buffers)
k.set("n", "<leader>/", tsb.current_buffer_fuzzy_find)
k.set("n", "<leader>pj", tsb.jumplist)
k.set("n", "<leader>pv", tsb.git_files)
k.set("n", "<leader>pf", tsb.find_files)
k.set("n", "<leader>pg", tsb.live_grep)
k.set("n", "<leader>pw", tsb.grep_string)
k.set("n", "<leader>pd", tsb.diagnostics)
