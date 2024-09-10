local M = {}

local server_name = 'dprint'
local pkg_name = 'dprint'

function M.setup()
    local lspconfig = require('lspconfig')
    local lsp_set = require('plugins_full.lsp.set')
    local cmd_path = require('util').get_cmd_path('dprint')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = lsp_set.enable_pkg[pkg_name],
        cmd = { cmd_path, 'lsp' },
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json', 'jsonc', 'markdown', 'python', 'toml', 'rust', 'roslyn' },
        root_dir = lspconfig.util.root_pattern('dprint.json', 'dprint.jsonc', '.dprint.json', '.dprint.jsonc', 'package.json', '.git'),
        single_file_support = true,
        capabilities = capabilities,
        settings = {},
        on_attach = lsp_set.on_attach_base,
    }

    lspconfig[server_name].setup(opts)
end

return M
