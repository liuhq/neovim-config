local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
---@param handlers table<string, lsp.Handler>
function M.setup(on_attach_base, handlers)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('vscode-css-language-server')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path, '--stdio' },
        filetypes = { 'css', 'scss', 'less' },
        single_file_support = true,
        capabilities = capabilities,
        init_options = {
            provideFormatter = true,
        },
        on_attach = function (client, bufnr)
            on_attach_base(client, bufnr)

            client.capabilities.textDocument.completion.completionItem.snippetSupport = true
        end,
        handlers = handlers,
        settings = {
            css = {
                validate = true,
            },
            less = {
                validate = true,
            },
            scss = {
                validate = true,
            },
        },
    }
    lspconfig['cssls'].setup(opts)
end

return M
