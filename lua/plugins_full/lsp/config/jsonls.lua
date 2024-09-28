local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
function M.setup(on_attach_base)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('vscode-json-language-server')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path, '--stdio' },
        filetypes = { 'json', 'jsonc' },
        root_dir = lspconfig.util.find_git_ancestor,
        single_file_support = true,
        capabilities = capabilities,
        -- settings = {
        -- },
        on_attach = function (client, bufnr)
            on_attach_base(client, bufnr)

            client.capabilities.textDocument.completion.completionItem.snippetSupport = true
        end,
    }
    lspconfig['jsonls'].setup(opts)
end

return M
