--- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#nixd
--- https://github.com/nix-community/nixd
---
--- install via nix: nix profile install github:nix-community/nixd

local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
---@param handlers table<string, lsp.Handler>
function M.setup(on_attach_base, handlers)
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { 'nixd' },
        filetypes = { 'nix' },
        single_file_support = true,
        capabilities = capabilities,
        on_attach = on_attach_base,
        handlers = handlers,
    }
    lspconfig['nixd'].setup(opts)
end

return M
