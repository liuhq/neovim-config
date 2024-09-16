return {
    'rcarriga/nvim-notify',
    -- event = 'VeryLazy',
    keys = {
        {
            '<leader>nn',
            function ()
                require('notify').dismiss({ silent = true, pending = true })
            end,
            desc = 'Dismiss All Notifications',
        },
        { '<leader>ns', '<cmd>Notifications<cr>', desc = 'Log Notifications' },
    },
    config = function ()
        local notify = require('notify')
        notify.setup({
            stages = 'static',
            timeout = 3000,
            max_height = function ()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function ()
                return math.floor(vim.o.columns * 0.75)
            end,
            on_open = function (win)
                vim.api.nvim_win_set_config(win, { zindex = 100 })
            end,
            -- render = 'compact',
            fps = 60,
            top_down = true,
        })

        require('telescope').load_extension('notify')
    end,
}
