return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function ()
        local npairs = require('nvim-autopairs')
        local npairs_rule = require('nvim-autopairs.rule')
        local npairs_cond = require('nvim-autopairs.conds')

        npairs.setup({
            disable_filetype = { 'TelescopePrompt' },
            ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
            enable_check_bracket_line = false,
            check_ts = false,
        })

        -- remove add single quote on filetype scheme or lisp
        npairs.get_rules("'")[1].not_filetypes = { 'racket', 'scheme', 'lisp' }
        npairs.get_rules("'")[1]:with_pair(npairs_cond.not_after_text('['))
        print(vim.inspect(npairs.get_rules("'")))

        -- auto-pair <> for generics
        npairs.add_rule(npairs_rule('<', '>', {
            '-racket',
            '-scheme',
            '-lisp',
            -- doesn't conflict with nvim-ts-autotag
            '-html',
            '-javascriptreact',
            '-typescriptreact',
        }):with_pair(
        -- regex will make it so that it will auto-pair on `a<` but not `a <`
        -- The `:?:?` part makes it also work on Rust generics like `some_func::<T>()`
            npairs_cond.before_regex('%a+:?:?$', 3)
        ):with_move(function (opts)
            return opts.char == '>'
        end))

        -- insert `(` after select function or method item
        local npairs_cmp = require('nvim-autopairs.completion.cmp')
        local npairs_handlers = require('nvim-autopairs.completion.handlers')
        local cmp = require('cmp')
        cmp.event:on(
            'confirm_done',
            npairs_cmp.on_confirm_done({
                filetypes = {
                    -- all filetypes
                    ['*'] = {
                        ['('] = {
                            kind = {
                                cmp.lsp.CompletionItemKind.Function,
                                cmp.lsp.CompletionItemKind.Method,
                            },
                            handler = npairs_handlers['*'],
                        },
                    },

                    -- lua = {
                    --     ['('] = {
                    --         kind = {
                    --             cmp.lsp.CompletionItemKind.Function,
                    --             cmp.lsp.CompletionItemKind.Method,
                    --         },
                    --         ---@param char string
                    --         ---@param item table item completion
                    --         ---@param bufnr number buffer number
                    --         ---@param rules table
                    --         ---@param commit_character table<string>
                    --         handler = function (char, item, bufnr, rules, commit_character)
                    --             -- Your handler function. Inspect with print(vim.inspect{char, item, bufnr, rules, commit_character})
                    --         end,
                    --     },
                    -- },

                    -- Disable for racket
                    racket = false,
                },
            })
        )
    end,
}
