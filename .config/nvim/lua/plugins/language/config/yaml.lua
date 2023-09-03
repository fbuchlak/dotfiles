local util = require("util.language")

return {
    { "b0o/SchemaStore.nvim", version = false },
    util.register_treesitter_languages({ "yaml" }),
    util.register_lsp_servers({
        yamlls = {
            on_new_config = function(new_config)
                new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
                vim.list_extend(new_config.settings.yaml.schemas, require("schemastore").yaml.schemas())
            end,
            settings = {
                redhat = {
                    telemetry = {
                        enabled = false,
                    },
                },
                yaml = {
                    keyOrdering = false,
                    format = {
                        enable = true,
                    },
                    validate = true,
                    schemaStore = { enable = false, url = "" },
                },
            },
        },
    }),
}
