return {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
        'hrsh7th/cmp-buffer',       -- buffer search auto-completion
        'hrsh7th/cmp-cmdline',      -- cmdline auto-completion
        'hrsh7th/cmp-nvim-lsp',     -- lsp auto-completion
        'hrsh7th/cmp-path',         -- path auto-completion
        { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
        'saadparwaiz1/cmp_luasnip', -- snippets auto-completion
    },
    config = function ()
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
                    -- winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu',
                },
            },
            formatting = {
                expandable_indicator = true,
                format = function (entry, vim_item)
                    if entry.source.name == 'emoji' then
                        vim_item.kind = 'emoji'
                        return vim_item
                    end
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
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-p>'] = cmp.mapping(function (_)
                    if cmp.visible() then
                        cmp.close()
                    else
                        cmp.complete()
                    end
                end, { 'i', 's' }),
                ['<tab>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
                ['<C-j>'] = cmp.mapping(function (fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's', 'c' }),
                ['<C-k>'] = cmp.mapping(function (fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's', 'c' }),
                ['<C-h>'] = cmp.mapping(function ()
                    if cmp.visible_docs() then
                        cmp.close_docs()
                    else
                        cmp.open_docs()
                    end
                end, { 'i', 's', 'c' }),
            }),
            sources = {
                {
                    name = 'nvim_lsp',
                    entry_filter = function (entry, _)
                        return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
                    end,
                },
                { name = 'luasnip' },
                { name = 'path' },
            },
        })

        -- `/` cmdline setup.
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            },
        })
        -- `:` cmdline setup.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' },
                    },
                },
            }),
        })

        -- LuaSnip snippets
        require('luasnip.loaders.from_snipmate').lazy_load()
    end,
}
