local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
function M.setup(on_attach_base)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('dot-language-server')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path, '--stdio' },
        filetypes = { 'dot' },
        root_dir = lspconfig.util.find_git_ancestor,
        single_file_support = true,
        capabilities = capabilities,
        on_attach = on_attach_base,
    }
    lspconfig['dotls'].setup(opts)
end

return M
