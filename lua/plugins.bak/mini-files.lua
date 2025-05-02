-- Show/Hide dot-files
local show_dotfiles = true

local filter_show = function (fs_entry)
    return fs_entry.name ~= '.git'
end

---@param fs_entry fs_entry
local filter_hide = function (fs_entry)
    return fs_entry.name ~= 'node_modules'
        and fs_entry.name ~= 'pnpm-lock.yaml'
        and fs_entry.name ~= 'Cargo.lock'
        and not vim.startswith(fs_entry.name, '.')
end


return {
    'echasnovski/mini.files',
    version = false,
    event = 'VeryLazy',
    keys = {
        {
            '<leader>e',
            function ()
                local files = require('mini.files')
                if not files.close() then
                    files.open(vim.fn.getcwd(), true, {
                        content = {
                            filter = show_dotfiles and filter_show or filter_hide,
                        },
                    })
                end
            end,
            desc = 'Mini Files',
        },
        {
            '<leader>r',
            function ()
                local path = vim.bo.buftype ~= 'nofile' and vim.api.nvim_buf_get_name(0) or nil
                local files = require('mini.files')
                if not files.close() then
                    files.open(path, true, {
                        content = {
                            filter = show_dotfiles and filter_show or filter_hide,
                        },
                    })
                end
            end,
            desc = 'Mini Files (Current)',
        },
    },
    init = function ()
        -- Check if the first argument is a directory
        local argv = vim.fn.argv(0)
        if vim.fn.isdirectory(argv) == 1 then
            if argv ~= '.' then
                vim.cmd('cd ' .. argv)
            end
            require('mini.files').open()
        end
    end,
    config = function ()
        local files = require('mini.files')
        files.setup({
            content = {
                ---@param fs_entry fs_entry
                filter = function (fs_entry)
                    return fs_entry.name ~= '.git'
                end,
            },
            mappings = {
                close = '<ESC>',
                go_in = 'L',
                go_in_plus = 'l',
            },
            options = {
                -- Whether to delete permanently or move into module-specific trash
                permanent_delete = false,
                use_as_default_explorer = true,
            },
            windows = {
                preview = true,
                width_preview = 75,
            },
        })

        -- Create mapping to show/hide dot-files
        local toggle_dotfiles = function ()
            show_dotfiles = not show_dotfiles
            local new_filter = show_dotfiles and filter_show or filter_hide
            MiniFiles.refresh({ content = { filter = new_filter } })
        end

        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesBufferCreate',
            callback = function (args)
                local buf_id = args.data.buf_id
                vim.keymap.set('n', 'gh', toggle_dotfiles, { buffer = buf_id })
            end,
        })

        -- Set current working directory
        local files_set_cwd = function (_)
            -- Works only if cursor is on the valid file system entry
            local cur_entry_path = files.get_fs_entry().path
            local cur_directory = vim.fs.dirname(cur_entry_path)
            vim.fn.chdir(cur_directory)
        end

        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesBufferCreate',
            callback = function (args)
                vim.keymap.set('n', 'gc', files_set_cwd, { buffer = args.data.buf_id, desc = 'Change cwd' })
            end,
        })

        -- Create mappings to modify target window via split
        local map_split = function (buf_id, lhs, direction)
            local rhs = function ()
                -- Make new window and set it as target
                local cur_target = MiniFiles.get_explorer_state().target_window
                local new_target = vim.api.nvim_win_call(cur_target, function ()
                    vim.cmd(direction .. ' split')
                    return vim.api.nvim_get_current_win()
                end)

                MiniFiles.set_target_window(new_target)

                MiniFiles.go_in({ close_on_file = true })
            end

            -- Adding `desc` will result into `show_help` entries
            local desc = 'Split ' .. direction
            vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
        end

        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesBufferCreate',
            callback = function (args)
                local buf_id = args.data.buf_id
                map_split(buf_id, '<C-s>', 'belowright horizontal')
                map_split(buf_id, '<C-v>', 'belowright vertical')
            end,
        })
    end,
}
