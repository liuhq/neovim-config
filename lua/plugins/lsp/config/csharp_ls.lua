local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
---@param handlers table<string, lsp.Handler>
function M.setup(on_attach_base, handlers)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('csharp-ls')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path },
        filetypes = { 'cs' },
        single_file_support = true,
        capabilities = capabilities,
        init_options = {
            AutomaticWorkspaceInit = true,
        },
        on_attach = on_attach_base,
        handlers = handlers,
    }
    lspconfig['csharp_ls'].setup(opts)
end

return M
