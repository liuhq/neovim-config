local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
---@param handlers table<string, lsp.Handler>
function M.setup(on_attach_base, handlers)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('bash-language-server')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path, 'start' },
        filetypes = { 'sh', 'zsh' },
        root_dir = lspconfig.util.find_git_ancestor,
        single_file_support = true,
        capabilities = capabilities,
        settings = {
            bashIde = {
                globPattern = '*@(.sh|.inc|.bash|.command)',
                shfmt = {
                    path = vim.fn.exepath('shfmt'),
                    binaryNextLine = true,
                    ignoreEditorconfig = false,
                },
                shellcheckPath = 'shellcheck',
                shellcheckArguments = ''
            },
        },
        on_attach = on_attach_base,
        handlers = handlers
    }
    lspconfig['bashls'].setup(opts)
end

return M
