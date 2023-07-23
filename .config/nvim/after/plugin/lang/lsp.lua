local lsp = vim.lsp
local with = lsp.with
local handlers = lsp.handlers

local opts = { border = "rounded" }

require("lspconfig.ui.windows").default_options = opts

handlers["textDocument/hover"] = with(handlers.hover, opts)
handlers["textDocument/signatureHelp"] = with(handlers.signature_help, opts)
