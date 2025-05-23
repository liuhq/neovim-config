return function ()
    MiniDeps.add({
        source = 'hrsh7th/nvim-cmp',
        depends = {
            'hrsh7th/cmp-buffer',   -- buffer search auto-completion
            'hrsh7th/cmp-cmdline',  -- cmdline auto-completion
            'hrsh7th/cmp-nvim-lsp', -- lsp auto-completion
            {
                source = 'L3MON4D3/LuaSnip',
                hooks = {
                    post_install = function (spec)
                        vim.system(
                            { 'make', 'install_jsregexp' },
                            { cwd = spec.path, text = true },
                            function (obj)
                                vim.notify(
                                    string.format('[%s::%s] make install_jsregexp', obj.signal, obj.code),
                                    vim.log.levels.INFO
                                )
                                if obj.stdout then
                                    vim.notify(obj.stdout, vim.log.levels.INFO)
                                end
                                if obj.stderr then
                                    vim.notify(obj.stderr, vim.log.levels.ERROR)
                                end
                            end)
                    end,
                    post_checkout = function (spec)
                        vim.system(
                            { 'make', 'install_jsregexp' },
                            { cwd = spec.path, text = true },
                            function (obj)
                                if obj.stdout then
                                    vim.notify(
                                        string.format('[%s::%s] %s', obj.signal, obj.code, obj.stdout),
                                        vim.log.levels.INFO
                                    )
                                end
                                if obj.stderr then
                                    vim.notify(
                                        string.format('[%s::%s] %s', obj.signal, obj.code, obj.stderr),
                                        vim.log.levels.ERROR
                                    )
                                end
                            end)
                    end,
                },
            },
            'saadparwaiz1/cmp_luasnip', -- snippets auto-completion
        },
    })


    local cmp = require('cmp')
    local luasnip = require('luasnip')

    cmp.setup({
        window = {
            completion = {
                col_offset = 1,
                side_padding = 0,
            },
            documentation = {
                border = 'solid',
            },
        },
        formatting = {
            expandable_indicator = true,
            format = function (entry, vim_item)
                vim_item.kind = string.lower(vim_item.kind)
                return vim_item
            end,
        },
        snippet = {
            expand = function (args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            --- unset
            ['<C-p>'] = cmp.mapping(function (fallback)
                fallback()
            end, { 'i', 'c' }),
            --- unset
            ['<C-n>'] = cmp.mapping(function (fallback)
                fallback()
            end, { 'i', 'c' }),

            ['<C-u>'] = cmp.mapping(function (fallback)
                if cmp.visible_docs() then
                    cmp.mapping.scroll_docs(-4)
                else
                    fallback()
                end
            end, { 'i', 'c' }),
            ['<C-d>'] = cmp.mapping(function (fallback)
                if cmp.visible_docs() then
                    cmp.mapping.scroll_docs(4)
                else
                    fallback()
                end
            end, { 'i', 'c' }),

            ['<C-o>'] = cmp.mapping(function (_)
                if cmp.visible() then
                    cmp.close()
                else
                    cmp.complete()
                end
            end, { 'i', 'c' }),
            ['<C-l>'] = cmp.mapping(function (fallback)
                if cmp.visible() then
                    cmp.confirm({ select = true })
                else
                    fallback()
                end
            end, { 'i', 'c' }),
            ['<tab>'] = cmp.mapping(function (fallback)
                if cmp.visible() then
                    if cmp.visible_docs() then
                        cmp.close_docs()
                    else
                        cmp.open_docs()
                    end
                else
                    fallback()
                end
            end, { 'i', 'c' }),

            ['<C-j>'] = cmp.mapping(function (fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 'c' }),
            ['<C-k>'] = cmp.mapping(function (fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 'c' }),
        }),
        sources = {
            {
                name = 'nvim_lsp',
                entry_filter = function (entry, _)
                    return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
                end,
            },
            { name = 'luasnip' },
        },
    })

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'cmdline' },
        },
        matching = { disallow_symbol_nonprefix_matching = false },
    })
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' },
        },
    })
    cmp.setup.cmdline('?', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' },
        },
    })

    -- LuaSnip snippets
    require('luasnip.loaders.from_vscode').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })
end
