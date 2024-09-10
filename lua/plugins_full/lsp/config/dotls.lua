local M = {}

local server_name = 'dotls'
local pkg_name = 'dot-language-server'

function M.setup()
    local lspconfig = require('lspconfig')
    local lsp_set = require('plugins_full.lsp.set')
    local cmd_path = require('util').get_cmd_path('dot-language-server')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = lsp_set.enable_pkg[pkg_name],
        cmd = { cmd_path, '--stdio' },
        filetypes = { 'dot' },
        root_dir = lspconfig.util.find_git_ancestor,
        single_file_support = true,
        capabilities = capabilities,
        on_attach = lsp_set.on_attach_base,
    }
    lspconfig[server_name].setup(opts)
end

return M
