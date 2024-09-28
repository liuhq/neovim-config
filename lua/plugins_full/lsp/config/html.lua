local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
function M.setup(on_attach_base)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('vscode-html-language-server')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
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
            on_attach_base(client, bufnr)

            client.capabilities.textDocument.completion.completionItem.snippetSupport = true
        end,
    }
    lspconfig['html'].setup(opts)
end

return M
