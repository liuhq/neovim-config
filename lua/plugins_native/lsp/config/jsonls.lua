local M = {}

local server_name = 'jsonls'
local pkg_name = 'json-lsp'

function M.setup()
    local lspconfig = require('lspconfig')
    local lsp_set = require('plugins_native.lsp.set')
    local cmd_path = require('util').get_cmd_path('vscode-json-language-server')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = lsp_set.enable_pkg[pkg_name],
        cmd = { cmd_path, '--stdio' },
        filetypes = { 'json', 'jsonc' },
        root_dir = lspconfig.util.find_git_ancestor,
        single_file_support = true,
        capabilities = capabilities,
        -- settings = {
        -- },
        on_attach = function (client, bufnr)
            lsp_set.on_attach_base(client, bufnr)

            client.capabilities.textDocument.completion.completionItem.snippetSupport = true
        end,
    }
    lspconfig[server_name].setup(opts)
end

return M
