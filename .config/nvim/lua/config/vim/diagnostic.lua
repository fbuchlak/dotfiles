local defaults = require("config.defaults")

for severity, icon in pairs(defaults.icons.diagnostic) do
    local name = "DiagnosticSign" .. severity
    vim.fn.sign_define(name, { texthl = name, text = icon, numhl = "" })
end

vim.diagnostic.config({
    virtual_text = {
        source = "always",
    },
    float = {
        border = defaults.border,
        source = "always",
        style = "minimal",
        header = "",
        prefix = "",
        suffix = "",
    },
})
