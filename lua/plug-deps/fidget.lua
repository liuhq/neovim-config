return function ()
    MiniDeps.add({ source = 'j-hui/fidget.nvim' })

    local fidget = require('fidget')
    local fidget_nt = require('fidget.notification')

    fidget.setup {
        progress = {
            display = {
                done_icon = '',
                overrides = {
                    lua_ls = { name = 'lua ls' },
                    rust_analyzer = {
                        name = 'rust analyzer',
                        -- icon = fidget.progress.display.for_icon(fidget.spinner.animate('dots', 2.5), '🦀'),
                        -- update_hook = function (item)
                        --     require('fidget.notification').set_content_key(item)
                        --     if item.hidden == nil and string.match(item.annote, 'clippy') then
                        --         -- Hide clippy-related notifications
                        --         item.hidden = true
                        --     end
                        -- end,
                    },
                },
            },
        },
        notification = {
            override_vim_notify = true,
            configs = { default = vim.tbl_deep_extend('force', fidget_nt.default_config, { icon = '' }) },
            window = {
                winblend = 0,
                y_padding = 1,
            },
        },
    }

    vim.keymap.set('n', '<leader>na', '<cmd>Fidget clear<cr>', { desc = 'Clear Active' })
    vim.keymap.set('n', '<leader>nc', '<cmd>Fidget clear_history<cr>', { desc = 'Clear Histories' })
    vim.keymap.set('n', '<leader>nh', '<cmd>Fidget history<cr>', { desc = 'Show Histories' })
end
