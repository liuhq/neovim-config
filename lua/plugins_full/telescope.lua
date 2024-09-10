return {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    keys = {
        { '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Search' },
        { '<leader>:', '<cmd>Telescope command_history previewer=false<cr>', desc = 'Command History' },
        { '<leader>"', '<cmd>Telescope registers<cr>', desc = 'Registers' },
        { '<leader><space>', '<cmd>Telescope find_files<cr>', desc = 'Files' },
        -- code --
        { '<leader>cd', '<cmd>Telescope lsp_definitions jump_type="tab drop" reuse_win=true<cr>', desc = 'Definition Picker' },
        { '<leader>ci', '<cmd>Telescope lsp_implementations jump_type="tab drop" reuse_win=true<cr>', desc = 'Implementation Picker' },
        { '<leader>cr', '<cmd>Telescope lsp_references jump_type="tab drop"<cr>', desc = 'References Picker' },
        { '<leader>ct', '<cmd>Telescope lsp_type_definitions jump_type="tab drop" reuse_win=true<cr>', desc = 'Type Definition Picker' },
        { '<leader>cc', '<cmd>Telescope lsp_incoming_calls<cr>', desc = 'Be Called (Incoming)' },
        { '<leader>cC', '<cmd>Telescope lsp_outgoing_calls<cr>', desc = 'To Call (Outgoing)' },
        { '<leader>cs', '<cmd>Telescope spell_suggest previewer=false<cr>', desc = 'S[p]ell Suggest' },
        { '<leader>cq', '<cmd>Telescope quickfix<cr>', desc = 'Quickfix list' },
        -- find & file --
        { '<leader>bb', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>', desc = 'Buffers' },
        { '<leader>fc', '<cmd>Telescope oldfiles<cr>', desc = 'Re[c]ent' },
        { '<leader>fC', '<cmd>Telescope oldfiles only_cwd=true<cr>', desc = 'Re[c]ent (cwd)' },
        { '<leader>ff', '<cmd>Telescope find_files follow=true hidden=true no_ignore=true no_ignore_parent=true<cr>', desc = 'All Files' },
        { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Grep' },
        { '<leader>fG', '<cmd>Telescope live_grep grep_open_files=true<cr>', desc = 'Grep (Opened Files)' },
        { '<leader>ft', '<cmd>Telescope filetypes<cr>', desc = 'Filetypes' },
        { '<leader>fw', '<cmd>Telescope grep_string word_match=-w<cr>', desc = 'Word' },
        { '<leader>fw', '<cmd>Telescope grep_string<cr>', mode = 'v', desc = 'Selection' },
        -- diagnostics
        { '<leader>xd', '<cmd>Telescope diagnostics bufnr=0<cr>', desc = 'Diagnostics' },
        { '<leader>xD', '<cmd>Telescope diagnostics<cr>', desc = 'Diagnostics (Workspace)' },
        -- git --
        {
            '<leader>gg',
            function ()
                local ok, _ = pcall(require('telescope.builtin').git_files, { show_untracked = true })
                if not ok then return vim.notify('[git_files] Not a git directory', 4) end
            end,
            desc = 'Files',
        },
        {
            '<leader>gc',
            function ()
                local ok, _ = pcall(require('telescope.builtin').git_commits)
                if not ok then return vim.notify('[git_commits] Not a git directory', 4) end
            end,
            desc = 'Commits',
        },
        {
            '<leader>gs',
            function ()
                local ok, _ = pcall(require('telescope.builtin').git_status)
                if not ok then return vim.notify('[git_status] Not a git directory', 4) end
            end,
            desc = 'Status',
        },
        -- jump --
        { '<leader>jj', '<cmd>Telescope jumplist<cr>', desc = 'Jumplist' },
        { '<leader>jl', '<cmd>Telescope loclist<cr>', desc = 'Location List' },
        -- notify --
        { '<leader>nh', '<cmd>Telescope notify<cr>', desc = 'Notify History Picker' },
        -- others --
        { '<leader>oa', '<cmd>Telescope autocommands previewer=false<cr>', desc = 'Autocommands' },
        { '<leader>ob', '<cmd>Telescope builtin include_extensions=true previewer=false<cr>', desc = 'Telescope Builtin' },
        { '<leader>oc', '<cmd>Telescope commands previewer=false<cr>', desc = 'Commands' },
        { '<leader>oC', '<cmd>Telescope colorscheme enable_preview=true<cr>', desc = 'Colorscheme with Preview' },
        { '<leader>oh', '<cmd>Telescope help_tags previewer=false<cr>', desc = 'Help Tags' },
        { '<leader>oH', '<cmd>Telescope highlights previewer=false<cr>', desc = 'Highlight Groups' },
        { '<leader>om', '<cmd>Telescope man_pages previewer=false<cr>', desc = 'Manuals' },
        { '<leader>oM', '<cmd>Telescope reloader previewer=false<cr>', desc = 'Modules' },
        { '<leader>ok', '<cmd>Telescope keymaps previewer=false<cr>', desc = 'Keymaps' },
        { '<leader>oo', '<cmd>Telescope vim_options previewer=false<cr>', desc = 'Nvim Options' },
    },
    opts = {
        defaults = {
            wrap_results = false,
            prompt_prefix = ' ',
            selection_caret = ' ',
            initial_mode = 'insert', -- insert | normal
            history = false,
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
        },
        pickers = {
            buffers = { initial_mode = 'normal' },
            colorscheme = { initial_mode = 'normal' },
            diagnostics = { initial_mode = 'normal' },
            jumplist = { initial_mode = 'normal' },
            loclist = { initial_mode = 'normal' },
            lsp_definitions = { initial_mode = 'normal' },
            lsp_incoming_calls = { initial_mode = 'normal' },
            lsp_outgoing_calls = { initial_mode = 'normal' },
            lsp_implementations = { initial_mode = 'normal' },
            lsp_references = { initial_mode = 'normal' },
            lsp_document_symbols = { initial_mode = 'normal' },
            lsp_dynamic_workspace_symbols = { initial_mode = 'normal' },
            lsp_type_definitions = { initial_mode = 'normal' },
            marks = { initial_mode = 'normal' },
            quickfix = { initial_mode = 'normal' },
            registers = { initial_mode = 'normal' },
            spell_suggest = { initial_mode = 'normal' },
        },
    },
    config = function (_, opts)
        local telescope = require('telescope')

        -- Flash Telescope config
        local function flash(prompt_bufnr)
            require('flash').jump({
                pattern = '^',
                label = { after = { 0, 0 } },
                search = {
                    mode = 'search',
                    exclude = {
                        function (win)
                            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'TelescopeResults'
                        end,
                    },
                },
                action = function (match)
                    local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
                    picker:set_selection(match.pos[1] - 1)
                end,
            })
        end
        opts.defaults = vim.tbl_deep_extend('force', opts.defaults, {
            mappings = { n = { s = flash }, i = { ['<c-s>'] = flash } },
        })

        telescope.setup(opts)
        telescope.load_extension('notify')
        telescope.load_extension('noice')
    end,
}
