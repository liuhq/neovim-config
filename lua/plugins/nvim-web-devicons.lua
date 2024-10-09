return {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    config = function ()
        local icons = require('nvim-web-devicons')
        icons.setup({
            override_by_filename = {
                ['license'] = {
                    icon = '󰿃',
                    color = '#f9e2af',
                    name = 'License',
                },
                ['makefile'] = {
                    icon = '',
                    color = '#7f849c',
                    name = 'Makefile',
                },
                ['readme.md'] = {
                    icon = '󱗖',
                    color = '#f5e0dc',
                    name = 'Readme',
                },
                ['txt'] = {
                    icon = '',
                    color = '#a6e3a1',
                    name = 'Txt',
                },
            },
            override_by_extension = {
                ['c'] = {
                    icon = '',
                    color = '#599eff',
                    name = 'C',
                },
                ['c++'] = {
                    icon = '',
                    color = '#f34b7d',
                    name = 'CPlusPlus',
                },
                ['cpp'] = {
                    icon = '',
                    color = '#519aba',
                    name = 'Cpp',
                },
                ['css'] = {
                    icon = '',
                    color = '#89b4fa',
                    name = 'Css',
                },
                ['cxx'] = {
                    icon = '',
                    color = '#519aba',
                    name = 'Cxx',
                },
                ['h'] = {
                    icon = '󰠩',
                    color = '#a074c4',
                    name = 'H',
                },
                ['html'] = {
                    icon = '',
                    color = '#fab387',
                    name = 'Html',
                },
                ['log'] = {
                    icon = '󰈙',
                    name = 'Log',
                },
                ['md'] = {
                    icon = '',
                    color = '#cdd6f4',
                    name = 'Markdown',
                },
                ['mdx'] = {
                    icon = '',
                    color = '#cdd6f4',
                    name = 'Markdown',
                },
                ['readme'] = {
                    icon = '󱗖',
                    color = '#f5e0dc',
                    name = 'Readme',
                },
                ['yml'] = {
                    icon = '',
                    color = '#7f849c',
                    name = 'Yaml',
                },
                ['yaml'] = {
                    icon = '',
                    color = '#7f849c',
                    name = 'Yaml',
                },
            },
        })
    end,
}
