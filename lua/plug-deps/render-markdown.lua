return function ()
    MiniDeps.add({
        source = 'MeanderingProgrammer/render-markdown.nvim',
        depends = { 'nvim-treesitter', 'nvim-web-devicons' },
    })

    require('render-markdown').setup({
        enabled = false,
        render_modes = { 'n', 'c' },
        anti_conceal = { enabled = false },
        file_types = { 'markdown' },
        injections = {
            gitcommit = {
                enabled = true,
                query = [[
                        ((message) @injection.content
                            (#set! injection.combined)
                            (#set! injection.include-children)
                            (#set! injection.language "markdown"))
                    ]],
            },
        },
        latex = { enabled = false },
    })

    vim.keymap.set('n', '<leader>m', '<cmd>RenderMarkdown toggle<cr>', { desc = 'Render Markdown' })
end
