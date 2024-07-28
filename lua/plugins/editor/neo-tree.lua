local icons = require('plugins.ui.icons')

return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    event = 'VeryLazy',
    -- stylua: ignore
    keys = {
        { '<leader>e', function() require('neo-tree.command').execute({ toggle = true }) end, desc = 'Files Explorer', },
    },
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    opts = {
        -- lua require("neo-tree").paste_default_config() - get the fully commented default config to a blank lua file
        sources = {
            'filesystem',
        },
        open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'edgy', 'Outline' }, -- when opening files, do not use windows containing these filetypes or buftypes
        resize_timer_interval = 100, -- in ms, needed for containers to redraw right aligned and faded content
        default_component_configs = {
            diagnostics = {
                symbols = {
                    hint = icons.diagnostics.Hint,
                    info = icons.diagnostics.Info,
                    warn = icons.diagnostics.Warn,
                    error = icons.diagnostics.Error,
                },
                highlights = {
                    hint = 'DiagnosticSignHint',
                    info = 'DiagnosticSignInfo',
                    warn = 'DiagnosticSignWarn',
                    error = 'DiagnosticSignError',
                },
                indent = {
                    -- expander config, needed for nesting files
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = '',
                    expander_expanded = '',
                    expander_highlight = 'NeoTreeExpander',
                },
            },
            name = {
                trailing_slash = false,
                highlight_opened_files = true, -- Requires `enable_opened_markers = true`.
                -- Take values in { false (no highlight), true (only loaded),
                -- "all" (both loaded and unloaded)}. For more information,
                -- see the `show_unloaded` config of the `buffers` source.
                use_git_status_colors = true,
                highlight = 'NeoTreeFileName',
            },
            type = {
                enabled = false,
            },
            last_modified = {
                enabled = false,
            },
            symlink_target = {
                enabled = true,
            },
        },
        window = {
            position = 'float', -- left, right, top, bottom, float, current
        },
        filesystem = {
            filtered_items = {
                visible = false, -- when true, they will just be displayed differently than normal items
                force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
                show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
                hide_dotfiles = false,
                hide_gitignored = true,
                hide_hidden = true, -- only works on Windows for hidden files/directories
                hide_by_name = {
                    '.DS_Store',
                    'thumbs.db',
                    'node_modules',
                    '.git',
                },
                hide_by_pattern = { -- uses glob style patterns
                    --"*.meta",
                    --"*/src/*/tsconfig.json"
                },
                always_show = { -- remains visible even if other settings would normally hide it
                    --".gitignored",
                },
                never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                    --".DS_Store",
                    --"thumbs.db"
                },
                never_show_by_pattern = { -- uses glob style patterns
                    --".null-ls_*",
                },
            },
            follow_current_file = {
                enabled = true, -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
            },
            hijack_netrw_behavior = 'open_current',
        },
    },
}
