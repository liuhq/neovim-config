return {
    'echasnovski/mini.ai',
    version = false,
    event = 'BufReadPost',
    config = function()
        local ai = require('mini.ai')
        ai.setup()
    end
}
