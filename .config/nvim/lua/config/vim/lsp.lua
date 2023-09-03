local defaults = require("config.defaults")

local opts = { border = defaults.border }

local with = vim.lsp.with
local handlers = vim.lsp.handlers
handlers["textDocument/hover"] = with(handlers.hover, opts)
handlers["textDocument/signatureHelp"] = with(handlers.signature_help, opts)
