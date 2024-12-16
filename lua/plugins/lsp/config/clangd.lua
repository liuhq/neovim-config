local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
---@param handlers table<string, lsp.Handler>
function M.setup(on_attach_base, handlers)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('clangd')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path },
        filetypes = {
            'c',
            'cpp',
            'objc',
            'objcpp',
            'cuda',
            'proto',
        },
        single_file_support = true,
        capabilities = capabilities,
        on_attach = function (client, bufnr)
            on_attach_base(client, bufnr)
        end,
        handlers = handlers,
    }
    lspconfig['clangd'].setup(opts)
end

return M
