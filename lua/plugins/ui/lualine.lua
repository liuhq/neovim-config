local icons = require('plugins.ui.icons')

return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
        options = {
            theme = 'catppuccin',
            section_separators = { left = icons.lualine_separator.sec_left, right = icons.lualine_separator.sec_right },
            component_separators = icons.lualine_separator.com_left,
            disabled_filetypes = {
                'dashboard',
                'starter',
            },
            ignore_focus = { 'TelescopePrompt' },
            globalstatus = true,
        },
        sections = {
            lualine_a = {
                {
                    'mode',
                    fmt = function(str)
                        return str:sub(1, 1)
                    end,
                    separator = {
                        left = icons.lualine_separator.special_le,
                        right = icons.lualine_separator.special_ri,
                    },
                },
            },
            lualine_b = {
                'branch',
                {
                    'diff',
                    symbols = {
                        added = icons.git.added,
                        modified = icons.git.modified,
                        removed = icons.git.removed,
                    },
                    -- source = function()
                    --     local gitsigns = vim.b.gitsigns_status_dict
                    --     if gitsigns then
                    --         return {
                    --             added = gitsigns.added,
                    --             modified = gitsigns.changed,
                    --             removed = gitsigns.removed,
                    --         }
                    --     end
                    -- end,
                },
            },
            lualine_c = {
                {
                    'diagnostics',
                    sources = { 'nvim_lsp', 'nvim_diagnostic' },
                    sections = { 'error', 'warn', 'info', 'hint' },
                    symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warn,
                        info = icons.diagnostics.Info,
                        hint = icons.diagnostics.Hint,
                    },
                },
            },
            lualine_x = {
                ---@diagnostic disable: undefined-field
                {
                    function() return require('noice').api.status.mode.get() end,
                    cond = function() return require('noice').api.status.mode.has() end,
                },
                {
                    function() return require('noice').api.status.command.get() end,
                    cond = function() return require('noice').api.status.command.has() end,
                },
                ---@diagnostic enable: undefined-field
                {
                    function()
                        return '  ' .. require('dap').status()
                    end,
                    cond = function()
                        return package.loaded['dap'] and require('dap').status() ~= ''
                    end,
                },
                {
                    require('lazy.status').updates,
                    cond = require('lazy.status').has_updates,
                },
            },
            lualine_y = {
                'filetype',
                {
                    'fileformat',
                    symbols = {
                        unix = 'LF', -- 
                        dos = 'CRLF', -- 
                        mac = 'LF', -- 
                    },
                },
                'encoding',
            },
            lualine_z = { { 'datetime', style = ' ' .. os.date('%R') } },
        },
        winbar = {
            lualine_a = {
                {
                    'buffers',
                    show_filename_only = true,
                    hide_filename_extension = false,
                    show_modified_status = false,
                    mode = 3,
                    use_mode_colors = true,
                    filetype_names = {
                        TelescopePrompt = 'Telescope',
                        dashboard = 'Dashboard',
                        ['neo-tree'] = 'Neotree',
                    },
                    -- buffers_color = {
                    --     -- Same values as the general color option can be used here.
                    --     active = 'lualine_{section}_normal', -- Color for active buffer.
                    --     inactive = 'lualine_{section}_inactive', -- Color for inactive buffer.
                    -- },
                    symbols = {
                        modified = ' ●', -- Text to show when the buffer is modified
                        alternate_file = '', -- Text to show to identify the alternate file
                        directory = '', -- Text to show when the buffer is a directory
                    },
                },
            },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {
                'searchcount',
                'selectioncount',
                'location',
                'progress',
            },
            lualine_y = {},
            lualine_z = {
                {
                    'filename',
                    file_status = true,
                    path = 4,
                    separator = {
                        left = icons.lualine_separator.special_le,
                        right = icons.lualine_separator.special_ri,
                    },
                },
            },
        },
        inactive_winbar = {
            lualine_a = {
                {
                    'buffers',
                    show_filename_only = true,
                    hide_filename_extension = false,
                    show_modified_status = false,
                    mode = 3,
                    use_mode_colors = true,
                    filetype_names = {
                        TelescopePrompt = 'Telescope',
                        dashboard = 'Dashboard',
                        ['neo-tree'] = 'Neotree',
                    },
                    -- buffers_color = {
                    --     -- Same values as the general color option can be used here.
                    --     active = 'lualine_{section}_normal', -- Color for active buffer.
                    --     inactive = 'lualine_{section}_inactive', -- Color for inactive buffer.
                    -- },
                    symbols = {
                        modified = ' ●', -- Text to show when the buffer is modified
                        alternate_file = '', -- Text to show to identify the alternate file
                        directory = '', -- Text to show when the buffer is a directory
                    },
                },
            },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {
                {
                    'filename',
                    file_status = true,
                    path = 4,
                    separator = {
                        left = icons.lualine_separator.special_le,
                        right = icons.lualine_separator.special_ri,
                    },
                },
            },
        },
        extensions = { 'lazy', 'mason', 'neo-tree', 'toggleterm', 'trouble' },
    },
}
