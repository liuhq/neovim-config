local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
---@param handlers table<string, lsp.Handler>
function M.setup(on_attach_base, handlers)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('vtsls')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
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
        on_attach = on_attach_base,
        handlers = handlers
    }

    lspconfig['vtsls'].setup(opts)
end

return M
