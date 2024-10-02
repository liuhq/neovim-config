local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
---@param handlers table<string, lsp.Handler>
function M.setup(on_attach_base, handlers)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('marksman')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path, 'server' },
        filetypes = { 'markdown', 'markdown.mdx' },
        root_dir = lspconfig.util.root_pattern('.git', '.marksman.toml'),
        single_file_support = true,
        capabilities = capabilities,
        on_attach = on_attach_base,
        handlers = handlers
    }
    lspconfig['marksman'].setup(opts)
end

return M