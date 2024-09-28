local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
function M.setup(on_attach_base)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('rust-analyzer')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path },
        filetypes = { 'rust' },
        root_dir = lspconfig.util.root_pattern('Cargo.toml', 'rust-project.json'),
        single_file_support = true,
        capabilities = capabilities,
        on_attach = function (client, bufnr)
            on_attach_base(client, bufnr)

            client.capabilities.experimental.serverStatusNotification = true
            client.server_capabilities.experimental.serverStatusNotification = true
        end,
    }
    lspconfig['rust_analyzer'].setup(opts)
end

return M
