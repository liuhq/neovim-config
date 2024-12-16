local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
---@param handlers table<string, lsp.Handler>
function M.setup(on_attach_base, handlers)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('tailwindcss-language-server')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path, '--stdio' },
        filetypes = {
            'aspnetcorerazor',
            'astro',
            'astro-markdown',
            'blade',
            'clojure',
            'django-html',
            'htmldjango',
            'edge',
            'eelixir',
            'elixir',
            'ejs',
            'erb',
            'eruby',
            'gohtml',
            'gohtmltmpl',
            'haml',
            'handlebars',
            'hbs',
            'html',
            'htmlangular',
            'html-eex',
            'heex',
            'jade',
            'leaf',
            'liquid',
            'markdown',
            'mdx',
            'mustache',
            'njk',
            'nunjucks',
            'php',
            'razor',
            'slim',
            'twig',
            'css',
            'less',
            'postcss',
            'sass',
            'scss',
            'stylus',
            'sugarss',
            'javascript',
            'javascriptreact',
            'reason',
            'rescript',
            'typescript',
            'typescriptreact',
            'vue',
            'svelte',
            'templ',
        },
        single_file_support = true,
        capabilities = capabilities,
        on_attach = on_attach_base,
        handlers = handlers,
        settings = {
            tailwindCSS = {
                classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
            },
        },
    }
    lspconfig['tailwindcss'].setup(opts)
end

return M
