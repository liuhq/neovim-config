return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'cmp-nvim-lsp',
    },
    keys = {
        { '[d', vim.diagnostic.goto_prev, desc = 'Prev Diagnostic' },
        { ']d', vim.diagnostic.goto_next, desc = 'Next Diagnostic' },
        { '<leader>xi', vim.diagnostic.open_float, desc = 'Diagnostic Info' },
        { '<leader>xm', vim.diagnostic.setloclist, desc = 'Mark Diagnostic' },
    },
    config = function ()
        local lspconfig = require('lspconfig')
        local preset = require('config.preset_lsp')
        local mason_lspconfig = require('mason-lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local icons = require('config.icons')

        mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(preset) })
        mason_lspconfig.setup_handlers({
            function (server_name)
                lspconfig[server_name].setup(vim.tbl_deep_extend('force', {
                    capabilities = capabilities,
                }, preset[server_name] or {}))
            end,
        })

        vim.diagnostic.config({
            severity_sort = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                    [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
                    [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                    [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
                },
                numhl = {
                    [vim.diagnostic.severity.WARN] = 'WarningMsg',
                    [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
                },
            },
            virtual_text = {
                prefix = icons.diagnostics.Sign,
                virt_text_pos = 'right_align',
            },
        })

        require('lspconfig.ui.windows').default_options.border = 'single'
    end,
}
