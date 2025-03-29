local logo = [[
                          |\\__/,|   (`\\
                        _.|o o   |_   ) ))
                      -(((---(((--------
░█▀█░█▀▀░█▀█░█░█░▀█▀░█▄█░░░░█▀▀░█░█░█░█░█░░
░█░█░█▀▀░█░█░▀▄▀░░█░░█░█░░░░█░░░░█░░█▀█░█░░
░▀░▀░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░▀░▀░░▀▀▀░░▀░░▀░▀░▀▀▀

]]

return {
    'echasnovski/mini.starter',
    lazy = false,
    config = function ()
        local starter = require('mini.starter')
        starter.setup({
            items = {
                starter.sections.recent_files(4, false, true),
                starter.sections.sessions(4, true),
                { name = 'New File', action = 'enew', section = 'Will do ...' },
                { name = 'Recent File', action = 'Telescope oldfiles', section = 'Will do ...' },
                { name = 'Edit Config', action = 'Telescope find_files cwd=' .. vim.fn.stdpath('config'), section = 'Will do ...' },
                { name = 'Quit Neovim', action = 'qall', section = 'Will do ...' },
            },
            header = logo,
            footer = (function ()
                local time = '⚡ Neovim loaded -/- plugins in -ms'

                vim.defer_fn(function ()
                    local stats = require('lazy').stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    time = '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
                    starter.refresh()
                end, 100)

                vim.defer_fn(function ()
                    local stats = require('lazy').stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    time = '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
                    starter.refresh()
                end, 500)

                local key_tip = [[
~~~~~~

<CR>     executes action of current item
<Esc>    resets current query
<M-j/k>  next/previous item
<BS>     deletes latest character from query
<C-c>    closes Starter
]]

                return function ()
                    return time .. '\n\n' .. key_tip
                end
            end)(),
            content_hooks = {
                starter.gen_hook.padding(16, 0),
                starter.gen_hook.adding_bullet('░ ', true),
                starter.gen_hook.aligning('left', 'center'),
            },
            silent = true,
        })
    end,
}
