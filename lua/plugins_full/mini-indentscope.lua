return {
    'echasnovski/mini.indentscope',
    event = 'BufReadPost',
    config = function ()
        local indentscope = require('mini.indentscope')
        indentscope.setup({
            draw = {
                delay = 50,
                animation = indentscope.gen_animation.linear({ duration = 10, unit = 'total' }),
            },
            symbol = '⁞',
        })
    end,
}
