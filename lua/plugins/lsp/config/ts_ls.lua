local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
---@param handlers table<string, lsp.Handler>
function M.setup(on_attach_base, handlers)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('typescript-language-server')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path, '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        single_file_support = true,
        capabilities = capabilities,
        on_attach = on_attach_base,
        handlers = handlers,
        init_options = { hostInfo = 'neovim' },
        settings = {
            javascript = {
                format = {
                    semicolons = 'remove',
                },
                inlayHints = {
                    functionLikeReturnTypes = { enabled = true },
                    propertyDeclarationTypes = { enabled = true },
                    variableTypes = { enabled = true },
                },
                preferGoToSourceDefinition = true,
                preferences = {
                    quoteStyle = 'single',
                },
            },
            typescript = {
                format = {
                    semicolons = 'remove',
                },
                inlayHints = {
                    enumMemberValues = { enabled = true },
                    functionLikeReturnTypes = { enabled = true },
                    propertyDeclarationTypes = { enabled = true },
                    variableTypes = { enabled = true },
                },
                preferGoToSourceDefinition = true,
                preferences = {
                    preferTypeOnlyAutoImports = true,
                    quoteStyle = 'single',
                },
                tsserver = {
                    experimental = {
                        enableProjectDiagnostics = true,
                    },
                },
            },
        },
    }

    lspconfig['ts_ls'].setup(opts)
end

return M
