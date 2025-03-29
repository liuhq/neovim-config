local icons = require('util').icons

return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'plenary.nvim',
        'nvim-web-devicons',
        'nui.nvim',
    },
    lazy = false,
    keys = {
        {
            '<leader>e',
            '<cmd>Neotree toggle=true reveal=true<cr>',
            desc = 'Open Neotree (Current file)',
        },
        {
            '<leader>bb',
            '<cmd>Neotree toggle=true reveal=true source=buffers<cr>',
            desc = 'Open Neotree Buffers',
        },
        {
            '<leader>gg',
            '<cmd>Neotree toggle=true reveal=true source=git_status<cr>',
            desc = 'Open Neotree Git Status',
        },
    },
    opts = {
        close_if_last_window = false,
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { 'help', 'terminal', 'trouble', 'qf' },
        filesystem = {
            hijack_netrw_behavior = 'open_default',
            components = {
                icon = function (config, node, _)
                    local highlights = require('neo-tree.ui.highlights')
                    local icon = config.default or ' '
                    local padding = config.padding or ' '
                    local highlight = config.highlight or highlights.FILE_ICON

                    if node.type == 'directory' then
                        highlight = highlights.DIRECTORY_ICON
                        if node:is_expanded() then
                            icon = ''
                        else
                            icon = ''
                        end
                    elseif node.type == 'file' then
                        local success, web_devicons = pcall(require, 'nvim-web-devicons')
                        if success then
                            local devicon, hl = web_devicons.get_icon(node.name, node.ext)
                            icon = devicon or icon
                            highlight = hl or highlight
                        end
                    end

                    return {
                        text = icon .. padding,
                        highlight = highlight,
                    }
                end,
            },
        },
        window = {
            position = 'float',
            popup = {
                position = { col = '100%', row = '0' },
                size = {
                    width = math.floor(vim.o.columns / 2),
                    height = vim.o.lines - 4,
                },
            },
        },
        source_selector = {
            sources = {
                {
                    source = 'filesystem', -- string
                    display_name = ' Files ', -- string | nil
                },
                {
                    source = 'buffers', -- string
                    display_name = ' Buffers ', -- string | nil
                },
                {
                    source = 'git_status', -- string
                    display_name = ' Git ', -- string | nil
                },
            },
        },
        ---@type neotree.Config.ComponentDefaults
        default_component_configs = {
            git_status = {
                symbols = {
                    -- Change type
                    added = icons.git.added,
                    deleted = icons.git.removed,
                    modified = icons.git.changed,
                    renamed = '󰁕',
                    -- Status type
                    untracked = '',
                    ignored = '',
                    unstaged = '󰄱',
                    staged = '',
                    conflict = '',
                },
            },
            indent = {
                indent_size = 2,
                with_markers = false,
                with_expanders = false,
            },
        },
    },
}
