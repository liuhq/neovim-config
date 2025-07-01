return function ()
    MiniDeps.add({
        source = 'stevearc/conform.nvim',
    })

    require('conform').setup({
        formatters_by_ft = {
            sh = { 'shfmt' },
            rust = { 'rustfmt' },
            javascript = { 'prettier', 'dprint', stop_after_first = true },
            javascriptreact = { 'prettier', 'dprint', stop_after_first = true },
            typescript = { 'prettier', 'dprint', stop_after_first = true },
            typescriptreact = { 'prettier', 'dprint', stop_after_first = true },
            html = { 'prettier', 'dprint', stop_after_first = true },
            css = { 'prettier', 'dprint', stop_after_first = true },
            json = { 'prettier', 'dprint', stop_after_first = true },
            jsonc = { 'prettier', 'dprint', stop_after_first = true },
            yaml = { 'dprint', 'yamlfmt', stop_after_first = true },
        },
        default_format_opts = {
            lsp_format = 'fallback',
        },
        formatters = {
            shfmt = { prepend_args = { '-i', '2' } },
            injected = { options = { ignore_errors = true } },
            prettier = {
                condition = function (_, ctx)
                    return vim.fs.find(
                        {
                            '.prettierrc',
                            '.prettierrc.json',
                            '.prettierrc.yml',
                            '.prettierrc.yaml',
                            '.prettierrc.json5',
                            '.prettierrc.js',
                            'prettier.config.js',
                            '.prettierrc.ts',
                            'prettier.config.ts',
                            '.prettierrc.mjs',
                            'prettier.config.mjs',
                            '.prettierrc.mts',
                            'prettier.config.mts',
                            '.prettierrc.cjs',
                            'prettier.config.cjs',
                            '.prettierrc.cts',
                            'prettier.config.cts',
                            '.prettierrc.toml',
                        },
                        { path = ctx.filename, upward = true, type = 'file' })[1]
                end,
            },
            dprint = {
                condition = function (_, ctx)
                    return vim.fs.find(
                        {
                            'dprint.json',
                            '.dprint.json',
                            'dprint.jsonc',
                            '.dprint.jsonc',
                        },
                        { path = ctx.filename, upward = true, type = 'file' })[1]
                end,
            },
        },
    })

    vim.o.formatexpr = 'v:lua.require("conform").formatexpr()'

    vim.keymap.set({ 'n', 'v' }, 'g=', function ()
        require('conform').format({ async = true }, function (err)
            if not err then
                local mode = vim.api.nvim_get_mode().mode
                if vim.startswith(string.lower(mode), 'v') then
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
                end
            end
        end)
    end, { desc = 'Format' })
end
