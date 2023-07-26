local lsp = vim.lsp

local opts = { border = "rounded" }

local handlers = lsp.handlers
local with = lsp.with
handlers["textDocument/hover"] = with(handlers.hover, opts)
handlers["textDocument/signatureHelp"] = with(handlers.signature_help, opts)

require("lspconfig.ui.windows").default_options = opts
