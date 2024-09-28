local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
function M.setup(on_attach_base)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('tailwindcss-language-server')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path, '--stdio' },
        filetypes = {
            'astro',
            'astro-markdown',
            'html',
            'markdown',
            'mdx',
            'css',
            'less',
            'postcss',
            'sass',
            'scss',
            'stylus',
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
            'vue',
            'svelte',
        },
        root_dir = lspconfig.util.root_pattern(
            'tailwind.config.js',
            'tailwind.config.cjs',
            'tailwind.config.mjs',
            'tailwind.config.ts',
            'postcss.config.js',
            'postcss.config.cjs',
            'postcss.config.mjs',
            'postcss.config.ts',
            'package.json',
            'node_modules',
            '.git'
        ),
        single_file_support = true,
        capabilities = capabilities,
        settings = {
            tailwindCSS = {
                classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
            },
        },
        on_attach = on_attach_base,
    }
    lspconfig['tailwindcss'].setup(opts)
end

return M
