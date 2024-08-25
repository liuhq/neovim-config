return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false,
        priority = 1000,
        opts = {
            flavour = 'mocha', -- latte, frappe, macchiato, mocha
            background = {     -- :h background
                light = 'latte',
                dark = 'mocha',
            },
            show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
            term_colors = true,        -- sets terminal colors (e.g. `g:terminal_color_0`)
            default_integrations = true,
            integrations = {
                cmp = true,
                dap = true,
                dap_ui = true,
                dashboard = true,
                flash = true,
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
                        errors = { 'underline' },
                        hints = { 'underline' },
                        warnings = { 'underline' },
                        information = { 'underline' },
                        ok = { 'underline' },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                noice = true,
                notify = true,
                treesitter = true,
                telescope = {
                    enabled = true,
                },
                which_key = true,
            },
        },
    },
}
