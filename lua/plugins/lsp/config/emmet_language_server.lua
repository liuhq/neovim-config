local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
---@param handlers table<string, lsp.Handler>
function M.setup(on_attach_base, handlers)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('emmet-language-server')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path, '--stdio' },
        filetypes = { 'css', 'eruby', 'html', 'htmldjango', 'javascriptreact', 'less', 'pug', 'sass', 'scss', 'typescriptreact', 'htmlangular' },
        root_dir = lspconfig.util.find_git_ancestor,
        single_file_support = true,
        capabilities = capabilities,
        on_attach = on_attach_base,
        handlers = handlers
    }
    lspconfig['emmet_language_server'].setup(opts)
end

return M
