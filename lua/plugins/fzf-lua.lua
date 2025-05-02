local icons = require('util').icons

return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
        { '<leader><space>', function () require('fzf-lua').files() end, desc = 'Files' },
        { '<leader>b', function () require('fzf-lua').buffers() end, desc = 'Buffers' },
        { '<leader>fs', function () require('fzf-lua').treesitter() end, desc = 'Treesitter Symbols' },
        { '<leader>ft', function () require('fzf-lua').filetypes() end, desc = 'Filetypes' },
        { '<leader>ss', function () require('fzf-lua').grep() end, desc = 'Grep' },
        { '<leader>sS', function () require('fzf-lua').live_grep() end, desc = 'Live Grep Current Project' },
        { '<leader>sc', function () require('fzf-lua').grep_cword() end, desc = 'Search Word Under Cursor' },
        { '<leader>cr', function () require('fzf-lua').lsp_references({ ignore_current_line = true }) end, desc = 'LSP References' },
        { '<leader>cd', function () require('fzf-lua').lsp_document_symbols() end, desc = 'LSP Document Symbols' },
        { '<leader>df', function () require('fzf-lua').diagnostics_document() end, desc = 'Current File Diagnostics' },
        { '<leader>dw', function () require('fzf-lua').diagnostics_workspace() end, desc = 'Workspace Diagnostics' },
        { mode = { 'v', 'i' }, '<C-x><C-f>', function () require('fzf-lua').complete_path() end, desc = 'Fuzzy Complete Path' },
    },
    config = function ()
        require('fzf-lua').setup({
            winopts = {
                row = 0.50,
                col = 0.50,
                border = 'solid',
                preview = {
                    border = 'solid',
                    vertical = 'down:45%',
                    horizontal = 'right:45%',
                    layout = 'flex',
                },
            },
            lsp = {
                symbols = {
                    symbol_style = 3,
                },
            },
            diagnostics = {
                signs = {
                    ['Error'] = { text = icons.diagnostics.Error },
                    ['Warn'] = { text = icons.diagnostics.Warn },
                    ['Hint'] = { text = icons.diagnostics.Hint },
                    ['Info'] = { text = icons.diagnostics.Info },
                },
            },
        })
    end,
}
