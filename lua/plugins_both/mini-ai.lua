return {
    'echasnovski/mini.ai',
    event = 'BufReadPost',
    config = function ()
        local ai = require('mini.ai')
        ai.setup()
    end,
}
