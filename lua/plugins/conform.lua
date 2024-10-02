---@type LazySpec
return {
    'stevearc/conform.nvim',
    cmd = 'ConformInfo',
    keys = {
        {
            '<leader>cf',
            function ()
                require('conform').format({ async = true }, function (err)
                    if not err then
                        local mode = vim.api.nvim_get_mode().mode
                        if vim.startswith(string.lower(mode), 'v') then
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
                        end
                    end
                end)
            end,
            desc = 'Format',
        },
    },
    opts = {
        formatters_by_ft = {
            sh = { 'shfmt' },
            rust = { 'rustfmt' },
            javascript = { 'prettier' },
        },
        default_format_opts = {
            lsp_format = 'fallback',
        },
        formatters = {
            shfmt = { prepend_args = { '-i', '2' } },
            injected = { options = { ignore_errors = true } },
            dprint = {
                condition = function (ctx)
                    return vim.fs.find({ 'dprint.json' }, { path = ctx.filename, upward = true })[1]
                end,
            },
        },
    },
    init = function ()
        vim.o.formatexpr = 'v:lua.require("conform").formatexpr()'
    end,
    config = function (_, opts)
        require('conform').setup(opts)
    end,
}
