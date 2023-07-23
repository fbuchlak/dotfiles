local cmp = require("cmp")
local cmap = cmp.mapping
local cwin = cmp.config.window

local snip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
snip.config.setup({})

cmp.setup({
    snippet = {
        expand = function(args)
            snip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cwin.bordered(),
        documentation = cwin.bordered(),
    },
    mapping = cmap.preset.insert({
        ["<C-Space>"] = cmap.complete({}),
        ["<C-n>"] = cmap.select_next_item(),
        ["<C-p>"] = cmap.select_prev_item(),
        ["<C-u>"] = cmap.scroll_docs(-4),
        ["<C-d>"] = cmap.scroll_docs(4),
        ["<CR>"] = cmap.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmap(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif snip.expand_or_locally_jumpable() then
                snip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmap(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif snip.locally_jumpable(-1) then
                snip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "tmux" },
    }, {
        { name = "buffer" },
        { name = "async_path" },
    }, {
        { name = "emoji" },
        { name = "nerdfont" },
    }),
})

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "async_path" },
    }, {
        { name = "cmdline" },
    }),
})
