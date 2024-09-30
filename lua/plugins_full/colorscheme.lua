return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false,
        priority = 1000,
        ---@type CatppuccinOptions
        opts = {
            flavour = 'mocha', -- latte, frappe, macchiato, mocha
            background = {     -- :h background
                light = 'latte',
                dark = 'mocha',
            },
            show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
            term_colors = false,       -- sets terminal colors (e.g. `g:terminal_color_0`)
            custom_highlights = function (colors)
                return {
                    CmpItemKindSnippet = { fg = colors.mauve, style = { 'italic' } },
                    CmpItemKindKeyword = { fg = colors.red, style = { 'italic' } },
                    CmpItemKindText = { fg = colors.teal, style = { 'italic' } },
                    CmpItemKindMethod = { fg = colors.blue, style = { 'italic' } },
                    CmpItemKindConstructor = { fg = colors.blue, style = { 'italic' } },
                    CmpItemKindFunction = { fg = colors.blue, style = { 'italic' } },
                    CmpItemKindFolder = { fg = colors.blue, style = { 'italic' } },
                    CmpItemKindModule = { fg = colors.blue, style = { 'italic' } },
                    CmpItemKindConstant = { fg = colors.peach, style = { 'italic' } },
                    CmpItemKindField = { fg = colors.green, style = { 'italic' } },
                    CmpItemKindProperty = { fg = colors.green, style = { 'italic' } },
                    CmpItemKindEnum = { fg = colors.green, style = { 'italic' } },
                    CmpItemKindUnit = { fg = colors.green, style = { 'italic' } },
                    CmpItemKindClass = { fg = colors.yellow, style = { 'italic' } },
                    CmpItemKindVariable = { fg = colors.flamingo, style = { 'italic' } },
                    CmpItemKindFile = { fg = colors.blue, style = { 'italic' } },
                    CmpItemKindInterface = { fg = colors.yellow, style = { 'italic' } },
                    CmpItemKindColor = { fg = colors.red, style = { 'italic' } },
                    CmpItemKindReference = { fg = colors.red, style = { 'italic' } },
                    CmpItemKindEnumMember = { fg = colors.red, style = { 'italic' } },
                    CmpItemKindStruct = { fg = colors.blue, style = { 'italic' } },
                    CmpItemKindValue = { fg = colors.peach, style = { 'italic' } },
                    CmpItemKindEvent = { fg = colors.blue, style = { 'italic' } },
                    CmpItemKindOperator = { fg = colors.blue, style = { 'italic' } },
                    CmpItemKindTypeParameter = { fg = colors.blue, style = { 'italic' } },
                    CmpItemKindCopilot = { fg = colors.teal, style = { 'italic' } },
                }
            end,
            default_integrations = true,
            integrations = {
                cmp = true,
                dap = true,
                fidget = true,
                flash = true,
                gitsigns = true,
                markdown = true,
                mason = true,
                mini = {
                    enabled = true,
                    indentscope_color = '',
                },
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { 'italic' },
                        hints = { 'italic' },
                        warnings = { 'italic' },
                        information = { 'italic' },
                        ok = { 'italic' },
                    },
                    underlines = {
                        errors = { 'undercurl' },
                        hints = { 'underline' },
                        warnings = { 'underline' },
                        information = { 'underline' },
                        ok = { 'underline' },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                navic = {
                    enabled = true,
                    custom_bg = 'NONE',
                },
                noice = true,
                notify = true,
                nvim_surround = true,
                render_markdown = true,
                treesitter = true,
                telescope = {
                    enabled = true,
                },
                which_key = true,
            },
        },
    },
}
