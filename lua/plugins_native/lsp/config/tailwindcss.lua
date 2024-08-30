local M = {}

local server_name = 'tailwindcss'
local pkg_name = 'tailwindcss-language-server'

function M.setup()
    local lspconfig = require('lspconfig')
    local lsp_set = require('plugins_native.lsp.set')
    local cmd_path = require('util').get_pkg_path(pkg_name, '/node_modules/.bin/', 'tailwindcss-language-server')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = lsp_set.enable_pkg[pkg_name],
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
        on_attach = lsp_set.on_attach_base,
    }
    lspconfig[server_name].setup(opts)
end

return M
