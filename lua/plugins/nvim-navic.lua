return {
    'SmiteshP/nvim-navic',
    lazy = true,
    config = function ()
        local navic = require('nvim-navic')
        navic.setup({
            icons = {
                File = ' ',
                Module = ' ',
                Namespace = ' ',
                Package = ' ',
                Class = ' ',
                Method = ' ',
                Property = ' ',
                Field = ' ',
                Constructor = ' ',
                Enum = ' ',
                Interface = ' ',
                Function = ' ',
                Variable = ' ',
                Constant = ' ',
                String = ' ',
                Number = ' ',
                Boolean = ' ',
                Array = ' ',
                Object = ' ',
                Key = ' ',
                Null = ' ',
                EnumMember = ' ',
                Struct = ' ',
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
