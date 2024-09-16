return {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
        'hrsh7th/cmp-cmdline',  -- cmdline auto-completion
        'hrsh7th/cmp-nvim-lsp', -- lsp auto-completion
        'hrsh7th/cmp-path',     -- path auto-completion
        { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
        'saadparwaiz1/cmp_luasnip',
    },
    config = function ()
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        cmp.setup({
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
            }),
            sources = {
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'luasnip' },
                { name = 'lazydev', group_index = 0 },
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
