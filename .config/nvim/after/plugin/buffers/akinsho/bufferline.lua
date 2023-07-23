local style = { bg = "NONE" }

require("bufferline").setup({
    highlights = require("catppuccin.groups.integrations.bufferline").get({
        custom = {
            all = {
                fill = style,
                background = style,
                tab = style,
                tab_selected = style,
                tab_separator = style,
                tab_separator_selected = style,
                buffer_selected = style,
                buffer_visible = style,
                separator_selected = style,
                offset_separator = style,
            },
        },
    }),
    options = {
        buffer_close_icon = "",
        offsets = {
            {
                filetype = "neo-tree",
                text = "NeoTree",
                text_align = "left",
                separator = true,
            },
        },
    },
})
