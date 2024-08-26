local icons = require('util').icons

return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'cmp-nvim-lsp',
    },
    keys = {
        { '[d', vim.diagnostic.goto_prev, desc = 'Prev Diagnostic' },
        { ']d', vim.diagnostic.goto_next, desc = 'Next Diagnostic' },
        { '<leader>xi', vim.diagnostic.open_float, desc = 'Diagnostic Info' },
        { '<leader>xm', vim.diagnostic.setloclist, desc = 'Mark Diagnostic' },
    },
    config = function ()
        require('plugins_native.lsp.config.bashls').setup()
        require('plugins_native.lsp.config.cssls').setup()
        require('plugins_native.lsp.config.dprint').setup()
        require('plugins_native.lsp.config.html').setup()
        require('plugins_native.lsp.config.jsonls').setup()
        require('plugins_native.lsp.config.lua_ls').setup()
        require('plugins_native.lsp.config.marksman').setup()
        require('plugins_native.lsp.config.vtsls').setup()

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
