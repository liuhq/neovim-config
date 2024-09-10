local M = {}

local server_name = 'taplo'
local pkg_name = 'taplo'

function M.setup()
    local lspconfig = require('lspconfig')
    local lsp_set = require('plugins_full.lsp.set')
    local cmd_path = require('util').get_cmd_path('taplo')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = lsp_set.enable_pkg[pkg_name],
        cmd = { cmd_path, 'lsp', 'stdio' },
        filetypes = { 'toml' },
        root_dir = lspconfig.util.root_pattern('*.toml', '.git'),
        single_file_support = true,
        capabilities = capabilities,
        on_attach = lsp_set.on_attach_base,
    }
    lspconfig[server_name].setup(opts)
end

return M
