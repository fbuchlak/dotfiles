local util = require("util")

local function call_telescope(func, selection, bufdir, opts)
    opts.additional_args = opts.additional_args or {}

    if selection then
        opts.default_text = util.get_visual_selection()
        table.insert(opts.additional_args, "-F")
    end

    if bufdir then
        opts.cwd = require("telescope.utils").buffer_dir()
    end

    if true == opts.hidden then
        table.insert(opts.additional_args, "--follow")
        table.insert(opts.additional_args, "--no-ignore")
        table.insert(opts.additional_args, "--hidden")
        table.insert(opts.additional_args, "--glob")
        table.insert(opts.additional_args, "!**/.git/*")
    end

    require("telescope.builtin")[func](opts)
end

local function create_telescope_call(func, selection, bufdir, opts)
    return function()
        call_telescope(func, selection, bufdir, opts)
    end
end

local function create_telescope_key(mode, key, func, opts, selection, bufdir, name, silent)
    return {
        key,
        create_telescope_call(func, selection, bufdir, opts),
        desc = "[Search]" .. name,
        mode = mode,
        silent = silent ~= false,
    }
end

local function create_telescope_search_keys(mode, prefix, opts, selection, bufdir, name_prefix)
    local create_key = function(key, func, name, modify_opts)
        if modify_opts then
            modify_opts(opts)
        end

        return create_telescope_key(mode, prefix .. key, func, opts, selection, bufdir, name_prefix .. " " .. name)
    end

    return {
        create_key("?", "builtin", "Telescope Builtins", function(o)
            o.include_extensions = true
        end),
        create_key("b", "buffers", "Buffers"),
        create_key("d", "diagnostics", "Diagnostics"),
        create_key("e", "oldfiles", "Recent Files", function(o)
            o.only_cwd = true
        end),
        create_key("f", "find_files", "Files"),
        create_key("g", "git_files", "Git Files", function(o)
            if true == o.hidden then
                o.show_untracked = true
            else
                o.recurse_submodules = true
            end
        end),
        create_key("h", "help_tags", "Help Tags"),
        create_key("j", "jumplist", "Jumps"),
        create_key("r", "resume", "Repeat Last Search"),
        create_key("s", "live_grep", "Grep"),
        create_key("w", "grep_string", "Current Word"),
    }
end

local function extension_config(extension)
    return function()
        require("telescope").load_extension(extension)
    end
end

return {
    {
        "nvim-telescope/telescope.nvim",
        version = false,
        cmd = "Telescope",
        opts = {
            pickers = {
                find_files = { theme = "dropdown" },
                frecency = { theme = "dropdown" },
            },
            defaults = {
                preview = {
                    filesize_limit = 1,
                },
            },
        },
        config = function(_, opts)
            util.create_autocmd("User", "telescope_preview_numbers", {
                pattern = "TelescopePreviewerLoaded",
                callback = function()
                    vim.opt_local.number = true
                end,
            })

            require("telescope").setup(opts)
        end,
        keys = function()
            -- stylua: ignore start
            local keys = {
                { "<Leader>f", "<CMD>Telescope resume<CR>", desc = "[Search] Resume", mode = { "n", "v" } },
                { "<Leader>sc", "<CMD>Telescope frecency workspace=CWD<CR>", desc = "[Search] Frequent Files", mode = { "n", "v" } },
                create_telescope_key("n", "<Leader>s/", "current_buffer_fuzzy_find", {}, false, false, " Fuzzy Grep Current Buffer"),
                create_telescope_key("v", "<Leader>s/", "current_buffer_fuzzy_find", {}, true, false, "[Selection] Fuzzy Grep Current Buffer"),
                create_telescope_key("n", "<Leader>s:", "command_history", {}, false, false, " Commands History"),
                create_telescope_key("v", "<Leader>s:", "command_history", {}, true, false, "[Selection] Commands History"),
            }

            local all_opts = { hidden = true, no_ignore = true, no_ignore_parent = true }

            -- search interactive
            for _, key in pairs(create_telescope_search_keys("n", "<Leader>s", {}, false, false, "")) do
                table.insert(keys, key)
            end

            -- search by selection
            for _, key in pairs(create_telescope_search_keys("v", "<Leader>s", {}, true, false, "[Selection]")) do
                table.insert(keys, key)
            end

            -- search all interactive
            for _, key in pairs(create_telescope_search_keys("n", "<Leader>sa", all_opts, false, false, "[All]")) do
                table.insert(keys, key)
            end

            -- search all by selection
            for _, key in pairs(create_telescope_search_keys("v", "<Leader>sa", all_opts, true, false, "[Selection][All]")) do
                table.insert(keys, key)
            end

            -- search current buffer dir interactive
            for _, key in pairs(create_telescope_search_keys("n", "<Leader>S", {}, false, true, "[Directory]")) do
                table.insert(keys, key)
            end

            -- search current buffer by selection
            for _, key in pairs(create_telescope_search_keys("v", "<Leader>S", {}, true, true, "[Directory][Selection]")) do
                table.insert(keys, key)
            end

            -- search current buffer all interactive
            for _, key in pairs(create_telescope_search_keys("n", "<Leader>Sa", all_opts, false, true, "[Directory][All]")) do
                table.insert(keys, key)
            end

            -- search current buffer all by selection
            for _, key in pairs(create_telescope_search_keys("v", "<Leader>Sa", all_opts, true, true, "[Directory][Selection][All]")) do
                table.insert(keys, key)
            end
            -- stylua: ignore end

            return keys
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
            return vim.fn.executable("make") == 1
        end,
        config = extension_config("fzf"),
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        config = extension_config("frecency"),
        dependencies = { "kkharji/sqlite.lua" },
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = extension_config("ui-select"),
    },
    {
        "nvim-telescope/telescope-media-files.nvim",
        config = extension_config("media_files"),
    },
    {
        "debugloop/telescope-undo.nvim",
        config = extension_config("undo"),
        keys = {
            { "<Leader>su", "<CMD>Telescope undo<CR>", desc = "[Search] Undotree" },
        },
    },
    {
        "benfowler/telescope-luasnip.nvim",
        module = "telescope._extensions.luasnip",
        config = extension_config("luasnip"),
        keys = {
            { "<Leader>si", "<CMD>Telescope luasnip<CR>", desc = "[Search] Snippets" },
        },
    },
    -- Optional
    {
        "folke/which-key.nvim",
        optional = true,
        opts = {
            defaults = {
                ["<Leader>s"] = { name = "[Search]", mode = { "n", "v" } },
                ["<Leader>S"] = { name = "[Search][Directory]", mode = { "n", "v" } },
                ["<Leader>sa"] = { name = "[Search][All]", mode = { "n", "v" } },
                ["<Leader>Sa"] = { name = "[Search][Directory][All]", mode = { "n", "v" } },
            },
        },
    },
}
