local M = {}

local server_name = 'vtsls'
local pkg_name = 'vtsls'

function M.setup()
    local lspconfig = require('lspconfig')
    local lsp_set = require('plugins_full.lsp.set')
    local cmd_path = require('util').get_cmd_path('vtsls')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = lsp_set.enable_pkg[pkg_name],
        cmd = { cmd_path, '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        root_dir = lspconfig.util.root_pattern('tsconfig.json', 'package.json', 'jsconfig.json', '.git'),
        single_file_support = true,
        capabilities = capabilities,
        settings = {
            vtsls = {
                autoUseWorkspaceTsdk = true,
                enableMoveToFileCodeAction = true,
                experimental = {
                    completion = {
                        enableServerSideFuzzyMatch = true,
                    },
                },
                javascript = {
                    format = {
                        convertTabsToSpaces = true,
                        indentSize = 4,
                        trimTrailingWhitespace = true,
                    },
                },
                typescript = {
                    format = {
                        convertTabsToSpaces = true,
                        indentSize = 4,
                        trimTrailingWhitespace = true,
                    },
                },
            },
            javascript = {
                preferGoToSourceDefinition = true,
                suggest = {
                    completeFunctionCalls = true,
                },
                inlayHints = {
                    variableTypes = {
                        enabled = true,
                    },
                    propertyDeclarationTypes = {
                        enabled = true,
                    },
                    functionLikeReturnTypes = {
                        enabled = true,
                    },
                },
                format = {
                    enable = true,
                    insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = true,
                    semicolons = 'remove',
                },
                preferences = {
                    quoteStyle = 'single',
                },
                updateImportsOnFileMove = {
                    enabled = 'always',
                },
            },
            typescript = {
                preferGoToSourceDefinition = true,
                suggest = {
                    completeFunctionCalls = true,
                },
                inlayHints = {
                    variableTypes = {
                        enabled = true,
                    },
                    propertyDeclarationTypes = {
                        enabled = true,
                    },
                    functionLikeReturnTypes = {
                        enabled = true,
                    },
                },
                format = {
                    enable = true,
                    insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = true,
                    semicolons = 'remove',
                },
                preferences = {
                    quoteStyle = 'single',
                },
                updateImportsOnFileMove = {
                    enabled = 'always',
                },
                tsserver = {
                    maxTsServerMemory = 3072, -- 8192 on large repo
                    --pluginPaths = ['./node_modules'] -- if ts plugins not activated in project local folder
                },
            },
        },
        on_attach = function (client, bufnr)
            lsp_set.on_attach_base(client, bufnr)

            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end,
    }

    lspconfig[server_name].setup(opts)
end

return M
