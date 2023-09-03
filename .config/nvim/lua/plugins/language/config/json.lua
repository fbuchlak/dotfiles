local util = require("util.language")

return {
    dependencies = { "b0o/SchemaStore.nvim", version = false },
    util.register_treesitter_languages({ "json", "json5", "jsonc" }),
    util.register_lsp_servers({
        jsonls = {
            on_new_config = function(new_config)
                new_config.settings.json.schemas = new_config.settings.json.schemas or {}
                vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
            end,
            settings = {
                json = {
                    format = {
                        enable = true,
                    },
                    validate = { enable = true },
                },
            },
        },
    }),
}
