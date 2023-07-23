local api = vim.api

local get_group_name = function(event, name)
    return "FBuchlak" .. event .. name
end

local create_event_autocmd = function(event, name, opts)
    opts.group = api.nvim_create_augroup(get_group_name(event, name), {
        clear = true,
    })

    api.nvim_create_autocmd(event, opts)
end

create_event_autocmd("TextYankPost", "Highlight", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

create_event_autocmd("BufWritePre", "DeleteTrailing", {
    command = [[%s/\s\+$//e]],
})

create_event_autocmd("VimResized", "FixSplits", {
    command = [[wincmd =]],
})
