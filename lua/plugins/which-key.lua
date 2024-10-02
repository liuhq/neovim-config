return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
        {
            '<leader>?',
            function ()
                require('which-key').show({ global = false })
            end,
            desc = 'Buffer Local Keymaps (which-key)',
        },
    },
    init = function ()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    ---@type wk.Opts
    opts = {
        preset = 'helix',
        delay = 0,
        notify = true,
        icons = {
            rules = false,
        },
        win = {
            border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
            --winblend = 20,
        },
        -- sort = { "local", "order", "group", "alphanum", "mod" },
        sort = { "order", "group", "alphanum", "mod" },
    },
    config = function (_, opts)
        local wk = require('which-key')
        wk.setup(opts)
        wk.add({
            { 'g', group = 'Goto', mode = { 'n', 'v' } },
            { 'gs', group = 'Selection', mode = { 'n', 'v' } },
            { 'z', group = 'Fold', mode = { 'n', 'v' } },
            { '[', group = 'Prev', mode = { 'n', 'v' } },
            { ']', group = 'Next', mode = { 'n', 'v' } },
            { '<leader>a', group = 'Manager' },
            { '<leader>b', group = 'Buffer' },
            { '<leader>c', group = 'Code' },
            { '<leader>e', group = 'Explorer' },
            { '<leader>f', group = 'File' },
            { '<leader>g', group = 'Git' },
            { '<leader>j', group = 'Jump' },
            { '<leader>m', group = 'Render' },
            { '<leader>n', group = 'Notification' },
            { '<leader>o', group = 'Others' },
            { '<leader>q', group = 'Quit/Session' },
            { '<leader>s', group = 'Search' },
            { '<leader>v', group = 'Dap' },
            { '<leader>w', group = 'Window' },
            { '<leader>x', group = 'Diagnostics' },
            { '<leader>z', group = 'Workspace' },
        })
    end,
}
