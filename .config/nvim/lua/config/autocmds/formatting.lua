require("util").create_autocmd({ "BufEnter", "BufRead" }, "opt_formatoptions", {
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions + "cr" - "o"
    end,
})
