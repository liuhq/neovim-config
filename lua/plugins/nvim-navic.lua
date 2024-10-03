return {
    'SmiteshP/nvim-navic',
    lazy = true,
    config = function ()
        local navic = require('nvim-navic')
        navic.setup({
            icons = {
                File = ' ',
                Module = ' ',
                Namespace = ' ',
                Package = ' ',
                Interface = ' ',
                Class = ' ',
                Constructor = ' ',
                Method = ' ',
                Property = ' ',
                Field = ' ',
                Function = ' ',
                Struct = ' ',
                Enum = ' ',
                EnumMember = ' ',
                Constant = ' ',
                Variable = ' ',
                String = ' ',
                Number = ' ',
                Boolean = ' ',
                Array = ' ',
                Object = ' ',
                Key = ' ',
                Null = ' ',
                Event = ' ',
                Operator = ' ',
                TypeParameter = ' ',
            },
            highlight = true,
            depth_limit = 0,
            depth_limit_indicator = '..',
            format_text = function (text)
                return text
            end,
            lazy_update_context = false,
            safe_output = true,
            click = false,
            lsp = {
                auto_attach = true,
                preference = { 'clangd', 'vtsls' },
            },
            separator = '  ',
        })

        vim.o.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
    end,
}
