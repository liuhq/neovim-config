local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
function M.setup(on_attach_base)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('taplo')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path, 'lsp', 'stdio' },
        filetypes = { 'toml' },
        root_dir = lspconfig.util.root_pattern('*.toml', '.git'),
        single_file_support = true,
        capabilities = capabilities,
        on_attach = on_attach_base,
    }
    lspconfig['taplo'].setup(opts)
end

return M
