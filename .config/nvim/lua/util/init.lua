local M = {}

function M.map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)

    return M
end

function M.toggle(options)
    if type(options) ~= "table" then
        options = { options }
    end

    for _, option in ipairs(options) do
        vim.opt_local[option] = not vim.opt_local[option]:get()
    end

    return M
end

---@param events table|string
---@param name string
---@param opts table
function M.create_autocmd(events, name, opts)
    if type(events) ~= "table" then
        events = { events }
    end

    for _, event in pairs(events) do
        name = name .. "_" .. event
    end

    opts.group = vim.api.nvim_create_augroup("custom_autocmd_" .. name, {
        clear = true,
    })

    vim.api.nvim_create_autocmd(events, opts)

    return M
end

function M.get_visual_selection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg("v")
    vim.fn.setreg("v", {})

    text = string.gsub(text, "\n", "")
    return #text > 0 and text or ""
end

function M.plugin_disable_for_bigfile(name, disable)
    return {
        "LunarVim/bigfile.nvim",
        opts = function(_, opts)
            if type(opts.features) == "table" then
                table.insert(opts.features, { name = name, disable = disable })
            end
        end,
    }
end

return M
