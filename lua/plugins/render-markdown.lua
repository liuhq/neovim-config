return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter', 'nvim-web-devicons' },
    cmd = 'RenderMarkdown',
    keys = {
        { '<leader>m', '<cmd>RenderMarkdown toggle<cr>', desc = 'Render Markdown' },
    },
    config = function ()
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
    end,
}
