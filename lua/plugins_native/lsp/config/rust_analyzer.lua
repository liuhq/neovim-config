local M = {}

local server_name = 'rust_analyzer'
local pkg_name = 'rust-analyzer'

function M.setup()
    local lspconfig = require('lspconfig')
    local lsp_set = require('plugins_native.lsp.set')
    local cmd_path = require('util').get_pkg_path(pkg_name, '/', 'rust-analyzer')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = lsp_set.enable_pkg[pkg_name],
        cmd = { cmd_path },
        filetypes = { 'rust' },
        root_dir = lspconfig.util.root_pattern('Cargo.toml', 'rust-project.json'),
        single_file_support = true,
        capabilities = capabilities,
        on_attach = function (client, bufnr)
            lsp_set.on_attach_base(client, bufnr)

            client.capabilities.experimental.serverStatusNotification = true
            client.server_capabilities.experimental.serverStatusNotification = true
        end,
    }
    lspconfig[server_name].setup(opts)
end

return M
