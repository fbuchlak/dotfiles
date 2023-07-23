local oil = require("oil")

oil.setup({
    default_file_explorer = false,
    keymaps = { ["H"] = "actions.parent" },
    view_options = { show_hidden = true },
})

vim.keymap.set("n", "<Leader>-", function()
    oil.open()
end, { desc = "Open oil" })
