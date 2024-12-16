local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
---@param handlers table<string, lsp.Handler>
function M.setup(on_attach_base, handlers)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('rust-analyzer')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path },
        filetypes = { 'rust' },
        single_file_support = true,
        capabilities = capabilities,
        before_init = function (init_params, config)
            -- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
            if config.settings and config.settings['rust-analyzer'] then
                init_params.initializationOptions = config.settings['rust-analyzer']
            end
        end,
        on_attach = function (client, bufnr)
            on_attach_base(client, bufnr)

            client.capabilities.experimental.serverStatusNotification = true
            client.server_capabilities.experimental.serverStatusNotification = true
        end,
        handlers = handlers,
    }
    lspconfig['rust_analyzer'].setup(opts)
end

return M
