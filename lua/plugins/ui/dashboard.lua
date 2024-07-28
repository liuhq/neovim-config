local logo = [[
                          |\\__/,|   (`\\  
                        _.|o o   |_   ) )) 
                      -(((---(((--------   
░█▀█░█▀▀░█▀█░█░█░▀█▀░█▄█░░░░█▀▀░█░█░█░█░█░░
░█░█░█▀▀░█░█░▀▄▀░░█░░█░█░░░░█░░░░█░░█▀█░█░░
░▀░▀░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░▀░▀░░▀▀▀░░▀░░▀░▀░▀▀▀
                                           
]]

logo = string.rep('\n', 8) .. logo .. '\n\n'

return {
    'nvimdev/dashboard-nvim',
    lazy = false,
    opts = {
        theme = 'doom',
        hide = {
            statusline = false,
        },
        config = {
            header = vim.split(logo, '\n'),
            -- stylua: ignore
            center = {
                { action = 'Telescope find_files cwd=~', icon = ' ', desc = ' Find File', key = 'f', },
                { action = 'ene', icon = ' ', desc = ' New File', key = 'n', },
                { action = 'Telescope oldfiles', icon = ' ', desc = ' Recent Files', key = 'r', },
                { action = 'Telescope persisted initial_mode=normal', icon = ' ', desc = ' Sessions', key = 's', },
                { action = 'Telescope find_files cwd=' .. vim.fn.stdpath('config'), icon = ' ', desc = ' Config', key = 'c', },
                { action = 'Lazy', icon = '󰒲 ', desc = ' Lazy', key = 'l', },
                { action = 'Mason', icon = ' ', desc = ' Mason', key = 'm', },
                { action = function() vim.api.nvim_input('<cmd>qa<cr>') end, icon = ' ', desc = ' Quit', key = 'q', },
            },
            footer = function()
                local stats = require('lazy').stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
            end,
            disable_move = true,
        },
    },
    config = function(_, opts)
        -- format actions
        for _, button in ipairs(opts.config.center) do
            button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
            button.key_format = '  %s'
        end

        require('dashboard').setup(opts)

        -- open dashboard after closing lazy
        if vim.o.filetype == 'lazy' then
            vim.api.nvim_create_autocmd('WinClosed', {
                pattern = tostring(vim.api.nvim_get_current_win()),
                once = true,
                callback = function()
                    vim.schedule(function()
                        vim.api.nvim_exec_autocmds('UIEnter', { group = 'dashboard' })
                    end)
                end,
            })
        end
    end,
}
