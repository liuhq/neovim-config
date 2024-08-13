return {
    'olimorris/persisted.nvim',
    lazy = true,
    keys = {
        { '<leader>qs', '<cmd>SessionSave<cr>', desc = 'Session Save' },
        { '<leader>qd', '<cmd>SessionDelete<cr>', desc = 'Delete Session' },
        { '<leader>ql', '<cmd>SessionLoad<cr>', desc = 'Session Load' },
        { '<leader>qt', '<cmd>Telescope persisted initial_mode=normal<cr>', desc = 'Session Toggle' },
    },
    opts = {
        save_dir = vim.fn.expand(vim.fn.stdpath('data') .. '/sessions/'),
        autosave = false,
        autoload = false,
    },
    config = function (_, opts)
        require('persisted').setup(opts)
        require('telescope').load_extension('persisted')

        -- local group = vim.api.nvim_create_augroup('PersistedHooks', {})
        --
        -- vim.api.nvim_create_autocmd({ 'User' }, {
        --     pattern = 'PersistedTelescopeLoadPre',
        --     group = group,
        --     callback = function(session)
        --         -- Save the currently loaded session using a global variable
        --         require('persisted').save({ session = vim.g.persisted_loaded_session })
        --
        --         -- Delete all of the open buffers
        --         vim.api.nvim_input('<ESC>:%bd!<CR>')
        --     end,
        -- })
    end,
}
