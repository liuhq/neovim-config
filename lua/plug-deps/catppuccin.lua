return function ()
    MiniDeps.add({
        source = 'catppuccin/nvim',
        name = 'catppuccin',
    })

    require('catppuccin').setup({
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        background = {     -- :h background
            light = 'latte',
            dark = 'mocha',
        },
        show_end_of_buffer = true,
        term_colors = false,
        styles = {
            keywords = { 'italic' },
        },
        color_overrides = {
            all = {
                text = '#eceff4',     -- #cdd6f4
                subtext1 = '#e5e9f0', -- #bac2de
                subtext0 = '#d8dee9', -- #a6adc8
            },
        },
        ---@type CtpHighlightOverrides
        highlight_overrides = {
            all = function (colors)
                return {
                    FloatBorder = { fg = colors.overlay0 },

                    FlashLabel = { fg = colors.red },
                    FlashMatch = { fg = colors.text },
                    FlashCurrent = { fg = colors.green },

                    StlCompBase = { fg = colors.text, bg = colors.crust },
                    StlCompModeNormal = { fg = colors.crust, bg = colors.lavender, style = { 'bold' } },
                    StlCompModeInsert = { fg = colors.crust, bg = colors.text, style = { 'bold' } },
                    StlCompModeVisual = { fg = colors.crust, bg = colors.green, style = { 'bold' } },
                    StlCompModeReplace = { fg = colors.crust, bg = colors.peach, style = { 'bold' } },
                    StlCompModeCommand = { fg = colors.crust, bg = colors.maroon, style = { 'bold' } },
                    StlCompModeDefault = { link = 'StlCompModeNormal' },
                    StlCompSecondary = { fg = colors.text, bg = colors.surface0 },
                    StlCompFlags = { fg = colors.yellow },
                    StlCompDiagError = { fg = colors.red, bg = colors.crust },
                    StlCompDiagWarn = { fg = colors.yellow, bg = colors.crust },
                    StlCompDiagInfo = { fg = colors.sky, bg = colors.crust },
                    StlCompDiagHint = { fg = colors.teal, bg = colors.crust },

                    Constant = { fg = colors.subtext0 },
                    Number = { fg = colors.subtext0 },
                    Boolean = { fg = colors.subtext0 },
                    Float = { fg = colors.subtext0 },
                    Identifier = { fg = colors.text },
                    Statement = { fg = colors.lavender },
                    Conditional = { fg = colors.sky },
                    Repeat = { fg = colors.sky },
                    Keyword = { fg = colors.sky },
                    Exception = { fg = colors.red },
                    Include = { fg = colors.sky },
                    Macro = { fg = colors.teal },

                    ['@lsp.type.enumMember'] = { fg = colors.sapphire },
                    ['@lsp.type.event'] = { fg = colors.mauve, style = { 'italic' } },
                    ['@lsp.type.keyword'] = { fg = colors.sky },
                    ['@lsp.type.macro'] = { fg = colors.teal },
                    ['@lsp.type.modifier'] = { fg = colors.sapphire },
                    ['@lsp.mod.async'] = { fg = colors.sapphire },

                    ['@constant'] = { fg = colors.subtext0 },
                    ['@constant.html'] = { fg = colors.peach },
                    ['@constant.builtin'] = { fg = colors.subtext0 },
                    ['@constant.macro'] = { fg = colors.subtext0 },
                    ['@module.builtin'] = { fg = colors.lavender },
                    ['@boolean'] = { fg = colors.subtext0 },
                    ['@number'] = { fg = colors.subtext0 },
                    ['@number.float'] = { fg = colors.subtext0 },
                    -- ['@function.builtin'] = { fg = colors.sapphire },
                    -- ['@function.method.call'] = { fg = colors.sapphire },
                    ['@keyword'] = { fg = colors.sky },
                    ['@keyword.coroutine'] = { fg = colors.sapphire },
                    ['@keyword.function'] = { fg = colors.sky },
                    ['@keyword.import'] = { fg = colors.sky },
                    ['@keyword.type'] = { fg = colors.sky },
                    ['@keyword.modifier'] = { fg = colors.sapphire },
                    ['@keyword.repeat'] = { fg = colors.sky },
                    ['@keyword.return'] = { fg = colors.sky },
                    ['@keyword.debug'] = { fg = colors.sky },
                    ['@keyword.exception'] = { fg = colors.red },
                    ['@keyword.conditional'] = { fg = colors.sky },
                    ['@keyword.conditional.ternary'] = { fg = colors.sky },
                    ['@markup.heading'] = { fg = colors.text },
                    ['@markup.heading.1'] = { fg = colors.text, style = { 'bold' } },
                    ['@markup.heading.2'] = { fg = colors.subtext1, style = { 'bold' } },
                    ['@markup.heading.3'] = { fg = colors.subtext1, style = { 'bold' } },
                    ['@markup.heading.4'] = { fg = colors.subtext0, style = { 'bold' } },
                    ['@markup.heading.5'] = { fg = colors.subtext0, style = { 'bold' } },
                    ['@markup.heading.6'] = { fg = colors.subtext0, style = { 'bold' } },
                    ['@markup.heading.1.vimdoc'] = { link = 'rainbow1' },
                    ['@markup.heading.2.vimdoc'] = { link = 'rainbow2' },
                    ['@markup.heading.3.vimdoc'] = { link = 'rainbow3' },
                    ['@markup.heading.4.vimdoc'] = { link = 'rainbow4' },
                    ['@markup.heading.5.vimdoc'] = { link = 'rainbow5' },
                    ['@markup.heading.6.vimdoc'] = { link = 'rainbow6' },
                    ['@tag'] = { fg = colors.blue },
                    ['@tag.builtin'] = { fg = colors.blue },
                    ['@tag.delimiter'] = { fg = colors.subtext0 },

                    --- css
                    ['@type.tag.css'] = { fg = colors.sapphire },
                    ['@variable.css'] = { fg = colors.sky },
                    ['@string.css'] = { fg = colors.subtext0 },
                    ['@number.css'] = { fg = colors.subtext0 },
                    ['@number.float.css'] = { fg = colors.subtext0 },
                }
            end,
        },
        default_integrations = true,
        integrations = {
            blink_cmp = true,
            fidget = true,
            flash = true,
            fzf = true,
            gitsigns = true,
            mini = { enabled = true },
            nvim_surround = true,
            which_key = true,
        },
    })

    vim.cmd.colorscheme('catppuccin')
end
