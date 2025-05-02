return {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function ()
        require('catppuccin').setup({
            flavour = 'mocha', -- latte, frappe, macchiato, mocha
            background = {     -- :h background
                light = 'latte',
                dark = 'mocha',
            },
            show_end_of_buffer = true,
            term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
            styles = {
                keywords = { 'italic' },
            },
            color_overrides = {
                all = {
                    -- rosewater = '#f5e0dc',
                    -- flamingo = '#f2cdcd',
                    -- pink = '#f5c2e7',
                    mauve = '#b48ead', -- #cba6f7
                    -- red = '#f38ba8',
                    -- maroon = '#eba0ac',
                    peach = '#d08770',    -- #fab387
                    yellow = '#ebcb8b',   -- #f9e2af
                    green = '#a3be8c',    -- #a6e3a1
                    teal = '#8fbcbb',     -- #94e2d5
                    -- sky = '#89dceb',
                    sapphire = '#5e81ac', -- #74c7ec
                    blue = '#81a1c1',     -- #89b4fa
                    lavender = '#88c0d0', -- #b4befe
                    text = '#eceff4',     -- #cdd6f4
                    subtext1 = '#e5e9f0', -- #bac2de
                    subtext0 = '#d8dee9', -- #a6adc8
                    -- overlay2 = '#9399b2',
                    -- overlay1 = '#7f849c',
                    overlay0 = '#4c566a', -- #6c7086
                    surface2 = '#434c5e', -- #585b70
                    surface1 = '#3b4252', -- #45475a
                    surface0 = '#2e3440', -- #313244
                    -- base = '#1e1e2e',
                    -- mantle = '#181825',
                    -- crust = '#11111b',
                },
            },
            ---@type CtpHighlightOverrides
            highlight_overrides = {
                all = function (colors)
                    return {
                        FloatBorder = { fg = colors.overlay0 },

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
                    }
                end,
            },
            default_integrations = true,
            integrations = {
                cmp = true,
                dap = true,
                fidget = true,
                flash = true,
                fzf = true,
                gitsigns = true,
                markdown = true,
                mason = true,
                mini = { enabled = true },
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
                nvim_surround = true,
                render_markdown = true,
                snacks = { enabled = true },
                treesitter = true,
                which_key = true,
            },
        })

        vim.cmd.colorscheme('catppuccin')
    end,
}
