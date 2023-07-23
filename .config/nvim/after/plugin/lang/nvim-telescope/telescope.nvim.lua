pcall(require("telescope").load_extension, "fzf")

local t = require("telescope.builtin")
local wk = require("which-key")

wk.register({
    E = {
        function()
            t.oldfiles({ only_cwd = true })
        end,
        "Find Old File",
    },
    f = {
        name = "Find",
        ["/"] = { t.current_buffer_fuzzy_find, "Find In Current Buffer" },
        b = { t.buffers, "Find Buffer" },
        d = { t.diagnostics, "Find Diagnostic" },
        f = { t.find_files, "Find File" },
        g = { t.live_grep, "Grep In Files" },
        h = { t.help_tags, "Find Help" },
        j = { t.jumplist, "Find Jump" },
        v = {
            function()
                t.git_files({
                    recurse_submodules = true,
                    show_untracked = true,
                })
            end,
            "Find Git File",
        },
        w = { t.grep_string, "Find Word" },
    },
}, { prefix = "<Leader>" })

local function get_visual_selection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg("v")
    vim.fn.setreg("v", {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
        return text
    else
        return ""
    end
end

local function t_visual(func, opts)
    opts.default_text = get_visual_selection()
    opts.additional_args = function(o)
        return vim.tbl_deep_extend("force", o, { "-F" })
    end

    t[func](opts)
end

wk.register({
    E = {
        function()
            t_visual("oldfiles", { only_cwd = true })
        end,
        "Find Old File",
    },
    f = {
        name = "Find",
        ["/"] = {
            function()
                t_visual("current_buffer_fuzzy_find", {})
            end,
            "Find In Current Buffer",
        },
        b = {
            function()
                t_visual("buffers", {})
            end,
            "Find Buffer",
        },
        d = {
            function()
                t_visual("diagnostics", {})
            end,
            "Find Diagnostic",
        },
        f = {
            function()
                t_visual("find_files", {})
            end,
            "Find File",
        },
        g = {
            function()
                t_visual("live_grep", {})
            end,
            "Grep In Files",
        },
        h = {
            function()
                t_visual("help_tags", {})
            end,
            "Find Help",
        },
        j = {
            function()
                t_visual("jumplist", {})
            end,
            "Find Jump",
        },
        v = {
            function()
                t_visual("git_files", {
                    recurse_submodules = true,
                    show_untracked = true,
                })
            end,
            "Find Git File",
        },
    },
}, { prefix = "<Leader>", mode = "v" })
