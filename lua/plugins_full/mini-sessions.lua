return {
    'echasnovski/mini.sessions',
    event = 'VeryLazy',
    keys = {
        { '<leader>ql', function () require('mini.sessions').select('read') end, desc = 'Load Session' },
        {
            '<leader>qs',
            function ()
                vim.ui.input({ prompt = 'Save Session' }, function (input)
                    input = input or 'Session.vim'
                    require('mini.sessions').write(input, { force = true })
                end)
            end,
            desc = 'Save Session',
        },
        { '<leader>qd', function () require('mini.sessions').select('delete') end, desc = 'Delete Session' },
        {
            '<leader>as',
            function ()
                local ntf = require('notify')
                local name = require('mini.sessions').get_latest()
                ntf(vim.inspect(name), vim.log.levels.INFO, { title = 'Latest Session' })
            end,
            desc = 'Latest Session',
        },
    },
    config = function ()
        local ses = require('mini.sessions')
        ses.setup({
            autoread = false,
            autowrite = false,
            directory = vim.fn.stdpath('data') .. '/session',
            file = 'Session.vim',
            force = { read = false, write = true, delete = false },
            verbose = { read = true, write = true, delete = true },
        })
    end,
}
