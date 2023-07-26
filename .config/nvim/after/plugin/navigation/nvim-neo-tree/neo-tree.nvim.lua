local t = require("telescope.builtin")

local function nt(state, func)
    t[func]({ cwd = state.tree:get_node().path })
end

local function nta(state, func)
    t[func]({
        cwd = state.tree:get_node().path,
        hidden = true,
        no_ignore = true,
        no_ignore_parent = true,
        additional_args = function()
            return {
                "--follow",
                "--no-ignore",
                "--hidden",
                "--glob",
                "!**/.git/*",
            }
        end,
    })
end

require("neo-tree").setup({
    event_handlers = {
        {
            event = "neo_tree_buffer_enter",
            handler = function()
                vim.cmd([[ setlocal nu relativenumber ]])
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
    window = {
        mappings = {
            ["<Leader>FAF"] = function(s)
                nta(s, "find_files")
            end,
            ["<Leader>FAG"] = function(s)
                nta(s, "live_grep")
            end,
            ["<Leader>FAV"] = function(s)
                nta(s, "git_files")
            end,
            ["<Leader>FF"] = function(s)
                nt(s, "find_files")
            end,
            ["<Leader>FG"] = function(s)
                nt(s, "live_grep")
            end,
            ["<Leader>FV"] = function(s)
                nt(s, "git_files")
            end,
            ["<space>"] = "none",
        },
    },
})

require("which-key").register({
    e = {
        name = "NeoTree",
        e = { "<CMD>Neotree<CR>", "NeoTree Focus" },
        r = { "<CMD>Neotree reveal<CR>", "NeoTree Reveal" },
        g = { "<CMD>Neotree float git_status<CR>", "NeoTree Git Status" },
        t = { "<CMD>Neotree toggle<CR>", "NeoTree Toggle" },
    },
}, { prefix = "<Leader>" })
