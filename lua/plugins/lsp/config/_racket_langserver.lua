--- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#racket_langserver
--- https://github.com/jeapostrophe/racket-langserver
---
--- install via raco: raco pkg install racket-langserver

local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
---@param handlers table<string, lsp.Handler>
function M.setup(on_attach_base, handlers)
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { 'racket', '--lib', 'racket-langserver' },
        filetypes = { 'racket', 'scheme' },
        single_file_support = true,
        capabilities = capabilities,
        on_attach = on_attach_base,
        handlers = handlers,
    }
    lspconfig['racket_langserver'].setup(opts)
end

return M
