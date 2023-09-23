local util = require("util.language")

return {
    "gbprod/php-enhanced-treesitter.nvim",
    {
        "gbprod/phpactor.nvim",
        ft = { "php", "yaml" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
        keys = {
            { "<Leader>gp", "<CMD>PhpActor context_menu<CR>", desc = "[PHP Actor] Menu" },
            { "<Leader>go", "<CMD>PhpActor navigate<CR>", desc = "[PHP Actor] Navigate" },
            { "<Leader>gv", "<CMD>PhpActor change_visibility<CR>", desc = "[PHP Actor] Change Visibility" },
        },
        opts = {
            install = {},
            lsp_config = { enabled = false },
        },
        config = function(_, opts)
            opts.install.bin = require("mason-registry").get_package("phpactor"):get_install_path() .. "/bin/phpactor"

            require("phpactor").setup(opts)
        end,
    },
    util.register_treesitter_languages({ "php", "phpdoc" }),
    util.register_lsp_servers({
        phpactor = {
            init_options = {
                ["language_server_phpstan.enabled"] = false,
                ["language_server_psalm.enabled"] = false,
            },
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
            handlers = { ["textDocument/publishDiagnostics"] = function() end },
        },
        intelephense = {
            on_attach = function(client)
                client.server_capabilities.callHierarchyProvider = false
                client.server_capabilities.completionProvider = false
                client.server_capabilities.definitionProvider = false
                client.server_capabilities.documentHighlightProvider = false
                client.server_capabilities.documentSymbolProvider = false
                client.server_capabilities.hoverProvider = false
                client.server_capabilities.implementationProvider = false
                client.server_capabilities.referencesProvider = false
                client.server_capabilities.semanticTokensProvider = false
                client.server_capabilities.signatureHelpProvider = false
                client.server_capabilities.typeDefinitionProvider = false
                client.server_capabilities.workspaceSymbolProvider = false
            end,
        },
    }),
    util.register_mason({
        "php-cs-fixer",
        "phpstan",
    }),
    util.configure_null_ls(function(_, opts)
        local nls = require("null-ls")
        opts.sources = opts.sources or {}
        vim.list_extend(opts.sources, {
            nls.builtins.formatting.phpcsfixer.with({
                env = {
                    PHP_CS_FIXER_IGNORE_ENV = true,
                },
                args = function()
                    local args = { "--no-interaction", "--quiet", "fix", "$FILENAME" }

                    if
                        not require("null-ls.utils").make_conditional_utils().root_has_file({
                            ".php-cs-fixer.php.dist",
                            ".php-cs-fixer.php",
                        })
                    then
                        -- https://cs.symfony.com/doc/ruleSets/Symfony.html
                        table.insert(
                            args,
                            "--rules=@Symfony,array_indentation,protected_to_private,phpdoc_annotation_without_dot,-no_superfluous_phpdoc_tags"
                        )
                    end

                    return args
                end,
            }),
            nls.builtins.diagnostics.phpstan.with({
                condition = function(utils)
                    return utils.root_has_file({
                        "phpstan.neon",
                        "phpstan.neon.dist",
                        "phpstan.dist.neon",
                    })
                end,
            }),
        })
    end),
    -- snippets
    "h4kst3r/php-awesome-snippets", -- vscode extension
    "nalabdou/symfony-code-snippets", -- vscode extension
}
