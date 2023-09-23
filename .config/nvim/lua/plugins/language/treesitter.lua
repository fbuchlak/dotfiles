local util = require("util")

---@param key_prefix string
---@param direction "Next"|"Previous"
local function map_treesitter_direction(key_prefix, direction)
    local dir_string = string.sub(direction, 0, 4)
    local jump_prefix = "<CMD>TSTextobjectGoto" .. direction
    local swap_prefix = "<CMD>TSTextobjectSwap" .. direction

    local m = function(key, rhs, desc)
        util.map({ "n", "v" }, key_prefix .. key, rhs, { desc = "[Jump " .. dir_string .. "][TreeSitter] " .. desc })
    end

    m("c", jump_prefix .. "Start @class.outer<CR>zz", "Class start")
    m("f", jump_prefix .. "Start @function.outer<CR>zz", "Function start")
    m("l", jump_prefix .. "Start @loop.outer<CR>zz", "Loop start")
    m("i", jump_prefix .. "Start @conditional.outer<CR>zz", "Conditional start")
    m("a", jump_prefix .. "Start @parameter.inner<CR>zz", "Parameter start")

    m("C", jump_prefix .. "End @class.outer<CR>zz", "Class end")
    m("F", jump_prefix .. "End @function.outer<CR>zz", "Function end")
    m("L", jump_prefix .. "End @loop.outer<CR>zz", "Loop end")
    m("I", jump_prefix .. "End @conditional.outer<CR>zz", "Conditional start")
    m("A", jump_prefix .. "End @parameter.inner<CR>zz", "Parameter end")

    m("sc", swap_prefix .. " @class.outer<CR>zz", "Swap Class")
    m("sf", swap_prefix .. " @function.outer<CR>zz", "Swap Function")
    m("sl", swap_prefix .. " @loop.outer<CR>zz", "Swap Loop")
    m("si", swap_prefix .. " @conditional.outer<CR>zz", "Swap Conditional")
    m("sa", swap_prefix .. " @parameter.inner<CR>zz", "Swap Parameter")
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        version = false,
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSUpdateSync" },
        opts = {
            ensure_installed = {},
            context_commentstring = { enable = true },
            auto_install = false,
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = "<Leader><Leader>",
                    node_decremental = "<Bs>",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["ai"] = "@conditional.outer",
                        ["ii"] = "@conditional.inner",
                        ["ax"] = "@constructor",
                    },
                },
                move = { enable = true, set_jumps = true },
                swap = { enable = true, repeatable = true },
                lsp_interop = {
                    enable = true,
                    floating_preview_opts = {
                        border = require("config.defaults").border,
                    },
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)

            map_treesitter_direction("<Leader>j", "Next")
            map_treesitter_direction("<Leader>k", "Previous")
            util.map(
                "n",
                "<Leader>ht",
                "<CMD>TSTextobjectPeekDefinitionCode @_start<CR>",
                { desc = "Show Treesitter Definition Code" }
            )

            local tsr = require("nvim-treesitter.textobjects.repeatable_move")
            local mode = { "n", "x", "o" }
            local mode_builtins = { "n", "x" }
            util.map(mode, ";", tsr.repeat_last_move)
                .map(mode, ",", tsr.repeat_last_move_opposite)
                .map(mode_builtins, "f", tsr.builtin_f)
                .map(mode_builtins, "F", tsr.builtin_F)
                .map(mode_builtins, "t", tsr.builtin_t)
                .map(mode_builtins, "T", tsr.builtin_T)
        end,
    },
}
