return {
    'echasnovski/mini.sessions',
    event = 'VeryLazy',
    keys = {
        { '<leader>ql', function () require('mini.sessions').select('read') end, desc = 'Load Session' },
        {
            '<leader>qs',
            function ()
                vim.ui.input({ prompt = 'Save Session:' }, function (input)
                    if input then
                        require('mini.sessions').write(input, { force = true })
                    end
                end)
            end,
            desc = 'Save Session',
        },
        { '<leader>qd', function () require('mini.sessions').select('delete') end, desc = 'Delete Session' },
        {
            '<leader>as',
            function ()
                local name = require('mini.sessions').get_latest()
                vim.notify(vim.inspect(name), vim.log.levels.INFO, { group = 'Latest Session' })
            end,
            desc = 'Latest Session',
        },
    },
    config = function ()
        local ses = require('mini.sessions')
        ses.setup({
            autoread = true,
            autowrite = false,
            directory = vim.fn.stdpath('data') .. '/session',
            file = 'session.vim',
            force = { read = false, write = true, delete = true },
            verbose = { read = true, write = true, delete = true },
        })
    end,
}
