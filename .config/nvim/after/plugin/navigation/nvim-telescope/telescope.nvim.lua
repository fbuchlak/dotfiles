pcall(require("telescope").load_extension, "fzf")

local builtin = require("telescope.builtin")
local wk = require("which-key")

require("telescope").setup({
    pickers = {
        find_files = { theme = "dropdown" },
        frecency = { theme = "dropdown" },
    },
})

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

local function t(func, selection, opts)
    local args = {}

    if selection then
        opts.default_text = get_visual_selection()
        table.insert(args, "-F")
    end

    if true == opts.hidden then
        table.insert(args, "--follow")
        table.insert(args, "--no-ignore")
        table.insert(args, "--hidden")
        table.insert(args, "--glob")
        table.insert(args, "!**/.git/*")
    end

    opts.additional_args = function()
        return args
    end

    builtin[func](opts)
end

local function create_find_group(opts, selection, name_suffix)
    local name = "Find" .. name_suffix

    return {
        name = name,
        ["/"] = {
            function()
                t("current_buffer_fuzzy_find", selection, opts)
            end,
            name .. " In Current Buffer",
        },
        b = {
            function()
                t("buffers", selection, opts)
            end,
            name .. " Buffer",
        },
        d = {
            function()
                t("diagnostics", selection, opts)
            end,
            name .. " Diagnostic",
        },
        f = {
            function()
                t("find_files", selection, opts)
            end,
            name .. " File",
        },
        g = {
            function()
                t("live_grep", selection, opts)
            end,
            name .. "[Grep] In Files",
        },
        h = {
            function()
                t("help_tags", selection, opts)
            end,
            name .. " Help",
        },
        j = {
            function()
                t("jumplist", selection, opts)
            end,
            name .. " Jump",
        },
        t = {
            function()
                opts.include_extensions = true

                t("builtin", selection, opts)
            end,
            name .. " Telescope pickers",
        },
        v = {
            function()
                if true == opts.hidden then
                    opts.show_untracked = true
                else
                    opts.recurse_submodules = true
                end

                t("git_files", selection, opts)
            end,
            name .. " Git File",
        },
        w = {
            function()
                t("grep_string", selection, opts)
            end,
            name .. "Find Word",
        },
    }
end

local fDefault = create_find_group({}, false, "")
fDefault.a = create_find_group({
    hidden = true,
    no_ignore = true,
    no_ignore_parent = true,
}, false, "[All]")
fDefault.e = { "<CMD>Telescope frecency theme=dropdown<CR>", "Telescope Frequent Files" }
fDefault.r = { "<CMD>Telescope resume<CR>", "Telescope Resume" }

wk.register({
    E = {
        function()
            t("oldfiles", false, { only_cwd = true })
        end,
        "Find Old File",
    },
    f = fDefault,
}, { prefix = "<Leader>" })

local fSelection = create_find_group({}, true, "[Selection]")
fSelection.a = create_find_group({
    hidden = true,
    no_ignore = true,
    no_ignore_parent = true,
}, true, "[Selection][All]")

wk.register({
    E = {
        function()
            t("oldfiles", true, { only_cwd = true })
        end,
        "Find[Selection] Old File",
    },
    f = fSelection,
}, { prefix = "<Leader>", mode = "v" })
