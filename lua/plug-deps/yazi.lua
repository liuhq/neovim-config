return function ()
    MiniDeps.add({
        source = 'mikavilpas/yazi.nvim',
        depends = { 'nvim-lua/plenary.nvim' },
    })

    require('yazi').setup({
        open_for_directories = true,
        highlight_groups = {
            hovered_buffer = { bg = '#313244' },
        },
        keymaps = {
            show_help = '<f1>',
            open_file_in_vertical_split = '<c-v>',
            open_file_in_horizontal_split = '<c-s>',
            open_file_in_tab = false,
            grep_in_directory = false,
            replace_in_directory = false,
            cycle_open_buffers = '<tab>',
            copy_relative_path_to_selected_files = false,
            send_to_quickfix_list = '<c-q>',
            change_working_directory = '<c-g>',
        },
        floating_window_scaling_factor = 1,
        yazi_floating_window_border = 'single',
    })

    vim.keymap.set('n', '<leader>e', '<cmd>Yazi<cr>', { desc = 'Open yazi (Current file)' })
    vim.keymap.set('n', '<leader>r', '<cmd>Yazi cwd<cr>', { desc = 'Open yazi (Root/cwd)' })
    vim.keymap.set('n', '<leader>t', '<cmd>Yazi toggle<cr>', { desc = 'Toggle yazi (Resume)' })

    vim.api.nvim_create_autocmd('VimEnter', {
        callback = function ()
            if vim.fn.argc() == 0 then
                require('yazi').yazi()
                vim.notify('Open in ' .. vim.fn.getcwd(), vim.log.levels.INFO)
            end
        end,
    })
end
