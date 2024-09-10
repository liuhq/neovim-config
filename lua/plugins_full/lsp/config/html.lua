local M = {}

local server_name = 'html'
local pkg_name = 'html-lsp'

function M.setup()
    local lspconfig = require('lspconfig')
    local lsp_set = require('plugins_full.lsp.set')
    local cmd_path = require('util').get_cmd_path('vscode-html-language-server')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = lsp_set.enable_pkg[pkg_name],
        cmd = { cmd_path, '--stdio' },
        filetypes = { 'html', 'templ' },
        root_dir = lspconfig.util.root_pattern('package.json', '.git'),
        single_file_support = true,
        capabilities = capabilities,
        init_options = {
            configurationSection = { 'html', 'css', 'javascript' },
            embeddedLanguages = {
                css = true,
                javascript = true,
            },
        },
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
