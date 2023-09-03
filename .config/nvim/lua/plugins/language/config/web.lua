local util = require("util.language")

local tsserver_format = {
    indentSize = vim.o.shiftwidth,
    convertTabsToSpaces = vim.o.expandtab,
    tabSize = vim.o.tabstop,
}

return {
    util.register_treesitter_languages({
        "astro",
        "css",
        "html",
        "javascript",
        "jsdoc",
        "prisma",
        "scss",
        "svelte",
        "tsx",
        "typescript",
        "vue",
    }),
    util.register_lsp_servers({
        cssls = {},
        emmet_ls = {
            filetypes = {
                "css",
                "eruby",
                "html",
                "javascript",
                "javascriptreact",
                "less",
                "sass",
                "scss",
                "svelte",
                "pug",
                "typescriptreact",
                "vue",
                -- added
                "blade",
                "twig",
            },
        },
        eslint = {
            settings = {
                workingDirectory = { mode = "auto" },
            },
        },
        html = {
            filetypes = { "html", "blade", "twig" },
        },
        svelte = {},
        tailwindcss = {},
        tsserver = {
            settings = {
                typescript = { format = tsserver_format },
                javascript = { format = tsserver_format },
                completions = {
                    completeFunctionCalls = true,
                },
            },
        },
        volar = {},
    }),
    util.register_mason({
        "prettierd",
    }),
    util.configure_null_ls(function(_, opts)
        local nls = require("null-ls")
        opts.sources = opts.sources or {}
        vim.list_extend(opts.sources, {
            nls.builtins.formatting.prettierd,
        })
    end),
}
