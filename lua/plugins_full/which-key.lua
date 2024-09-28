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
            { '<leader>d', group = 'Dap' },
            { '<leader>e', group = 'Explorer' },
            { '<leader>f', group = 'Find/File' },
            { '<leader>g', group = 'Git' },
            { '<leader>j', group = 'Jump' },
            { '<leader>n', group = 'Notify' },
            { '<leader>o', group = 'Others' },
            { '<leader>q', group = 'Quit/Session' },
            { '<leader>s', group = 'Search' },
            { '<leader>t', group = 'Tab' },
            { '<leader>w', group = 'Window/Workspace' },
            { '<leader>x', group = 'Diagnostics' },
        })
    end,
}
