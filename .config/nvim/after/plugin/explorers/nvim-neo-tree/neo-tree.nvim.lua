local t = require("telescope.builtin")

local function nt(state, func, opts)
    opts.cwd = state.tree:get_node().path

    t[func](opts)
end

require("neo-tree").setup({
    window = {
        commands = {},
        mappings = {
            ["<space>"] = nil,
            ["<Leader>ff"] = function(state)
                nt(state, "find_files", {})
            end,
            ["<Leader>fg"] = function(state)
                nt(state, "live_grep", {})
            end,
        },
    },
    filesystem = {
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true,
        follow_current_file = false,
        filtered_items = {
            visible = true,
        },
    },
})

require("which-key").register({
    e = {
        name = "NeoTree",
        e = { ":NeoTreeFocus<CR>", "NeoTree Focus" },
        g = { ":Neotree float git_status<CR>", "NeoTree Git Status [float]" },
        t = { ":NeoTreeFocusToggle<CR>", "NeoTree Toggle" },
    },
}, { prefix = "<Leader>" })
