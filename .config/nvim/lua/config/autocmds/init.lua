require("config.autocmds.filetype")
require("config.autocmds.formatting")
require("config.autocmds.visuals")

vim.cmd([[autocmd BufEnter *.pdf execute "!xdg-open '%' &" | bdelete %]])
