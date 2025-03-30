return {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    keys = {
        { '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Search' },
        { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
        { '<leader>"', '<cmd>Telescope registers<cr>', desc = 'Registers' },
        { '<leader><space>', '<cmd>Telescope find_files<cr>', desc = 'Files' },
        -- code --
        { '<leader>cs', '<cmd>Telescope spell_suggest<cr>', desc = 'Spell Suggest' },
        { '<leader>l', '<cmd>Telescope quickfix<cr>', desc = 'Quickfix list' },
        -- find & file --
        { '<leader>b', '<cmd>Telescope buffers bufnr_width=4 select_current=true<cr>', desc = 'Buffers' },
        { '<leader>ff', '<cmd>Telescope find_files follow=true hidden=true no_ignore=true no_ignore_parent=true<cr>', desc = 'All Files' },
        { '<leader>ss', '<cmd>Telescope live_grep<cr>', desc = 'Grep' },
        { '<leader>so', '<cmd>Telescope live_grep grep_open_files=true<cr>', desc = 'Grep (Opened Files)' },
        { '<leader>ft', '<cmd>Telescope filetypes<cr>', desc = 'Filetypes' },
        -- diagnostics
        { '<leader>xd', '<cmd>Telescope diagnostics bufnr=0<cr>', desc = 'Diagnostics' },
        { '<leader>xa', '<cmd>Telescope diagnostics<cr>', desc = 'Diagnostics (Workspace)' },
        -- others --
        { '<leader>ob', '<cmd>Telescope builtin include_extensions=true<cr>', desc = 'Telescope Builtin' },
        { '<leader>od', '<cmd>Telescope commands<cr>', desc = 'Commands' },
        { '<leader>ok', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },
    },
    config = function ()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local themes = require('telescope.themes')

        local dropdown = themes.get_dropdown({
            borderchars = {
                prompt = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
                results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
                preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            },
            layout_config = { width = 0.4 },
            previewer = false,
            winblend = 20,
        })
        local ivy = themes.get_ivy({
            borderchars = {
                prompt = { '─', ' ', ' ', ' ', '─', '─', ' ', ' ' },
                results = { ' ' },
                preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            },
            layout_config = { preview_width = 0.64 },
        })

        local opts = {
            defaults = {
                borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                wrap_results = false,
                prompt_prefix = ' ',
                selection_caret = '▐ ',
                entry_prefix = '  ',
                initial_mode = 'insert', -- insert | normal
                history = false,
                layout_config = {
                    center = {
                        preview_width = 0.64,
                    },
                    horizontal = {
                        preview_width = 0.64,
                    },
                    vertical = {
                        preview_width = 0.64,
                    },
                },
                -- open files in the first window that is an actual file.
                -- use the current window if no other window is available.
                get_selection_window = function ()
                    local wins = vim.api.nvim_list_wins()
                    table.insert(wins, 1, vim.api.nvim_get_current_win())
                    for _, win in ipairs(wins) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        if vim.bo[buf].buftype == '' then
                            return win
                        end
                    end
                    return 0
                end,
                mappings = {
                    --- Note:
                    ---   <C-q> open all result files
                    ---   <M-q> open selected result files
                    i = {
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-m>'] = actions.toggle_selection,
                        ['<C-a>'] = actions.toggle_all,
                        ['<C-u>'] = actions.preview_scrolling_up,
                        ['<C-d>'] = actions.preview_scrolling_down,
                        ['<C-h>'] = actions.preview_scrolling_left,
                        ['<C-l>'] = actions.preview_scrolling_right,
                        ['<C-f>'] = actions.results_scrolling_down,
                        ['<C-b>'] = actions.results_scrolling_up,
                        ['<M-h>'] = actions.results_scrolling_left,
                        ['<M-l>'] = actions.results_scrolling_right,
                        ['<C-o>'] = actions.select_drop,
                        ['<C-x>'] = actions.select_horizontal,
                        ['<C-v>'] = actions.select_vertical,
                        ['<C-t>'] = actions.select_tab,
                        ['<CR>'] = actions.select_default,
                        ['<C-c>'] = actions.close,
                        ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
                        ['<C-n>'] = false,
                    },
                    n = {
                        ['<j>'] = actions.move_selection_next,
                        ['<k>'] = actions.move_selection_previous,
                        ['o'] = actions.select_drop,
                        ['<C-o>'] = actions.drop_all, -- select_all
                        ['<q>'] = actions.send_selected_to_loclist,
                        ['<space>'] = actions.select_default,
                        ['<esc>'] = actions.close,
                        ['m'] = actions.toggle_selection,
                        ['<C-a>'] = actions.toggle_all,

                        ['<C-u>'] = actions.preview_scrolling_up,
                        ['<C-d>'] = actions.preview_scrolling_down,
                        ['<C-h>'] = actions.preview_scrolling_left,
                        ['<C-l>'] = actions.preview_scrolling_right,
                        ['<C-f>'] = actions.results_scrolling_down,
                        ['<C-b>'] = actions.results_scrolling_up,
                        ['<M-h>'] = actions.results_scrolling_left,
                        ['<M-l>'] = actions.results_scrolling_right,
                        ['<C-x>'] = actions.select_horizontal,
                        ['<C-v>'] = actions.select_vertical,
                        ['<C-t>'] = actions.select_tab,
                        ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
                        ['<C-n>'] = false,
                    },
                },
            },
            pickers = {
                current_buffer_fuzzy_find = vim.tbl_deep_extend('force', dropdown, { layout_config = { width = 0.8 } }),
                command_history = dropdown,
                registers = vim.tbl_deep_extend('force', dropdown, { initial_mode = 'normal' }),
                find_files = dropdown,
                spell_suggest = vim.tbl_deep_extend('force', dropdown, { initial_mode = 'normal' }),
                quickfix = vim.tbl_deep_extend('force', dropdown, { initial_mode = 'normal' }),
                buffers = vim.tbl_deep_extend('force', dropdown, { initial_mode = 'normal' }),
                oldfiles = dropdown,
                live_grep = ivy,
                filetypes = dropdown,
                diagnostics = { initial_mode = 'normal' },
                jumplist = { initial_mode = 'normal' },
                loclist = { initial_mode = 'normal' },
                marks = { initial_mode = 'normal' },
                autocommands = vim.tbl_deep_extend('force', dropdown, { layout_config = { width = 0.5 } }),
                builtin = dropdown,
                commands = vim.tbl_deep_extend('force', dropdown, { layout_config = { width = 0.5 } }),
                colorscheme = vim.tbl_deep_extend('force', dropdown, { initial_mode = 'normal' }),
                help_tags = dropdown,
                highlights = dropdown,
                man_pages = dropdown,
                reloader = dropdown,
                keymaps = dropdown,
                vim_options = dropdown,
            },
        }

        telescope.setup(opts)
    end,
}
