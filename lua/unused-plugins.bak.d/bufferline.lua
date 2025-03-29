local icons = require('util').icons

return {
    'akinsho/bufferline.nvim',
    version = '*',
    event = 'BufReadPost',
    keys = {
        { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = 'Pin Buffer' },
        { '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', desc = 'Delete Other Buffers' },
    },
    config = function ()
        require('bufferline').setup({
            options = {
                mode = 'buffers',
                themable = true,
                numbers = function (opts)
                    ---@diagnostic disable-next-line: undefined-field
                    return opts.raise(opts.id)
                end,
                indicator = {
                    style = 'underline',
                },
                modified_icon = icons.file_status.modified,
                left_trunc_marker = '',
                right_trunc_marker = '',
                name_formatter = function (buf)
                    ---@diagnostic disable-next-line: undefined-field
                    if vim.bo[buf.bufnr].filetype == 'qf' then
                        return 'Quickfix List'
                    end
                    ---@diagnostic disable-next-line: undefined-field
                    return buf.name
                end,
                diagnostics = 'nvim_lsp',
                diagnostics_indicator = function (_, level)
                    local s = level:match('error') and icons.diagnostics.Error or ''
                    return '' .. s
                end,
                color_icons = true,
                show_buffer_icons = true,
                show_buffer_close_icons = false,
                show_close_icon = false,
                show_tab_indicators = true,
                show_duplicate_prefix = true,
                separator_style = 'thin',
                always_show_bufferline = false,
            },
            highlights = require('catppuccin.groups.integrations.bufferline').get(),
        })
    end,
}
