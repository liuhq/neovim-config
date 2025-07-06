---@brief
--- https://github.com/tailwindlabs/tailwindcss-intellisense
---
--- Tailwind CSS Language Server can be installed via npm:
---
--- npm install -g @tailwindcss/language-server
---

return {
    cmd = { 'tailwindcss-language-server', '--stdio' },
    -- filetypes copied and adjusted from tailwindcss-intellisense
    filetypes = {
        -- html
        'astro',
        'astro-markdown',
        'html',
        'mdx',
        -- css
        'css',
        'postcss',
        -- js
        'javascriptreact',
        'typescriptreact',
        -- mixed
        'vue',
    },
    settings = {
        tailwindCSS = {
            validate = true,
            lint = {
                cssConflict = 'warning',
                invalidApply = 'error',
                invalidScreen = 'error',
                invalidVariant = 'error',
                invalidConfigPath = 'error',
                invalidTailwindDirective = 'error',
                recommendedVariantOrder = 'warning',
            },
            classAttributes = {
                'class',
                'className',
                'classList',
            },
            includeLanguages = {
                templ = 'html',
            },
        },
    },
    before_init = function (_, config)
        if not config.settings then
            config.settings = {}
        end
        if not config.settings.editor then
            config.settings.editor = {}
        end
        if not config.settings.editor.tabSize then
            config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
        end
    end,
    workspace_required = true,
    root_dir = function (bufnr, on_dir)
        local root_files = {
            'tailwind.config.js',
            'tailwind.config.cjs',
            'tailwind.config.mjs',
            'tailwind.config.ts',
            'postcss.config.js',
            'postcss.config.cjs',
            'postcss.config.mjs',
            'postcss.config.ts',
        }
        local fname = vim.api.nvim_buf_get_name(bufnr)
        -- root_files = util.insert_package_json(root_files, 'tailwindcss', fname)
        on_dir(vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1]))
    end,
}
