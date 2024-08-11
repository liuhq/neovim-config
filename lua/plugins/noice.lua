return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    keys = {
        -- stylua: ignore start
        { '<leader>nl', '<cmd>Noice last<cr>',      desc = 'Noice Last Message', },
        { '<leader>nh', '<cmd>Noice history<cr>',   desc = 'Noice History', },
        { '<leader>na', '<cmd>Noice all<cr>',       desc = 'Noice All', },
        { '<leader>nd', '<cmd>Noice dismiss<cr>',   desc = 'Dismiss All', },
        { '<leader>nt', '<cmd>Noice telescope<cr>', desc = 'Noice History (Telescope)', },
        -- stylua: ignore end
        {
            '<C-f>',
            function()
                if not require('noice.lsp').scroll(4) then
                    return '<C-f>'
                end
            end,
            silent = true,
            expr = true,
            desc = 'Scroll Forward',
            mode = { 'n', 'i', 's' },
        },
        {
            '<C-b>',
            function()
                if not require('noice.lsp').scroll(-4) then
                    return '<C-b>'
                end
            end,
            silent = true,
            expr = true,
            desc = 'Scroll Backward',
            mode = { 'n', 'i', 's' },
        },
    },
    opts = {
        lsp = {
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = true,
            lsp_doc_border = true,
        },
        routes = {
            { -- route long messages to split
                filter = {
                    event = 'msg_show',
                    any = { { min_height = 5 }, { min_width = 200 } },
                    ['not'] = {
                        kind = { 'confirm', 'confirm_sub', 'return_prompt', 'quickfix', 'search_count' },
                    },
                    blocking = false,
                },
                view = 'messages',
                opts = { stop = true },
            },
            { -- route long messages to split
                filter = {
                    event = 'msg_show',
                    any = { { min_height = 5 }, { min_width = 200 } },
                    ['not'] = {
                        kind = { 'confirm', 'confirm_sub', 'return_prompt', 'quickfix', 'search_count' },
                    },
                    blocking = true,
                },
                view = 'mini',
            },
            { -- hide `written` message
                filter = {
                    event = 'msg_show',
                    kind = '',
                    find = 'written',
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = 'msg_show',
                    any = {
                        { find = '%d+L, %d+B' },
                        { find = '; after #%d+' },
                        { find = '; before #%d+' },
                        { find = 'fewer lines' },
                    },
                },
                view = 'mini',
            },
        },
    },
    config = function(_, opts)
        require('noice').setup(opts)
        require('telescope').load_extension('noice')
    end,
}
