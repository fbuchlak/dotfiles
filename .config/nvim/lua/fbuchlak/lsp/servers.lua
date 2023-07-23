return {
    awk_ls = {},
    bashls = {},
    clangd = {},
    cssls = {},
    emmet_ls = {},
    gopls = {},
    html = {},
    intelephense = {},
    jsonls = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim" } },
        },
    },
    tailwindcss = {},
    taplo = {},
    tsserver = {},
    rust_analyzer = {},
}
