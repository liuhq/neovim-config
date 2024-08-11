return {
    'echasnovski/mini.files',
    version = false,
    event = 'VeryLazy',
    keys = {
        {
            '<leader>e',
            function()
                local files = require('mini.files')
                if not files.close() then
                    files.open()
                end
            end,
            desc = 'Mini Files'
        },
        {
            '<leader>E',
            function()
                local path = vim.bo.buftype ~= "nofile" and vim.api.nvim_buf_get_name(0) or nil
                local files = require('mini.files')
                if not files.close() then
                    files.open(path)
                end
            end,
            desc = 'Mini Files (Current)'
        }
    },
    init = function()
        -- Check if the first argument is a directory
        local argv = vim.fn.argv(0)
        if vim.fn.isdirectory(argv) == 1 then
            if argv ~= '.' then
                -- Change to the directory
                vim.cmd('cd ' .. argv)
            end
            -- Open mini.files
            require('mini.files').open()
        end
    end,
    config = function()
        local files = require('mini.files')
        files.setup({
            content = {
                ---@param fs_entry fs_entry
                filter = function(fs_entry)
                    return fs_entry.name ~= '.git' and fs_entry.name ~= '.DS_Store'
                end,
            },
            mappings = {
                go_in = 'L',
                go_in_plus = 'l',
            },
            options = {
                -- Whether to delete permanently or move into module-specific trash
                permanent_delete = true,
                use_as_default_explorer = true,
            },
            windows = {
                preview = true,
                width_preview = 75,
            }
        })

        -- Hide from .gitignore
        local show_ignorefiles = true

        ---@param fs_entries fs_entry[]
        local hide_ignorefiles = function(fs_entries)
            local all_paths = table.concat(
                vim.tbl_map(function(entry)
                    return entry.path
                end, fs_entries),
                '\n'
            )
            local output_lines = {}
            local job_id = vim.fn.jobstart({ 'git', 'check-ignore', '--stdin' }, {
                stdout_buffered = true,
                on_stdout = function(_, data)
                    output_lines = data
                end,
            })

            -- command failed to run
            if job_id < 1 then
                vim.notify('Failed Toggle Hide.', vim.log.levels.ERROR)
                return fs_entries
            end

            -- send paths via STDIN
            vim.fn.chansend(job_id, all_paths)
            vim.fn.chanclose(job_id, 'stdin')
            vim.fn.jobwait({ job_id })
            return files.default_sort(vim.tbl_filter(function(entry)
                return not vim.tbl_contains(output_lines, entry.path)
            end, fs_entries))
        end

        local toggle_ignorefiles = function()
            show_ignorefiles = not show_ignorefiles
            local new_sorter = show_ignorefiles and files.default_sort or hide_ignorefiles
            files.refresh({ content = { sort = new_sorter } })
        end

        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesBufferCreate',
            callback = function(args)
                local buf_id = args.data.buf_id
                vim.keymap.set('n', 'g.', toggle_ignorefiles, { buffer = buf_id, desc = 'Hide from GitIgnore' })
            end,
        })

        -- Set current working directory
        local files_set_cwd = function(path)
            -- Works only if cursor is on the valid file system entry
            local cur_entry_path = files.get_fs_entry().path
            local cur_directory = vim.fs.dirname(cur_entry_path)
            vim.fn.chdir(cur_directory)
        end

        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesBufferCreate',
            callback = function(args)
                vim.keymap.set('n', 'g~', files_set_cwd, { buffer = args.data.buf_id, desc = 'Change cwd' })
            end,
        })
    end
}
