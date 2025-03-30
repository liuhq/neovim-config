local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
---@param handlers table<string, lsp.Handler>
function M.setup(on_attach_base, handlers)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('vscode-json-language-server')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path, '--stdio' },
        filetypes = { 'json', 'jsonc' },
        single_file_support = true,
        capabilities = capabilities,
        init_options = {
            provideFormatter = true,
        },
        on_attach = function (client, bufnr)
            on_attach_base(client, bufnr)

            client.capabilities.textDocument.completion.completionItem.snippetSupport = true
        end,
        handlers = handlers,
        settings = {
            json = {
                schemas = {
                    {
                        fileMatch = { 'package.json' },
                        url = 'https://json.schemastore.org/package.json',
                    },
                    {
                        fileMatch = { 'tsconfig*.json' },
                        url = 'https://json.schemastore.org/tsconfig.json',
                    },
                    {
                        fileMatch = {
                            '.prettierrc',
                            '.prettierrc.json',
                            'prettier.config.json',
                        },
                        url = 'https://json.schemastore.org/prettierrc.json',
                    },
                    {
                        fileMatch = { '.eslintrc', '.eslintrc.json' },
                        url = 'https://json.schemastore.org/eslintrc.json',
                    },
                    {
                        fileMatch = {
                            'dprint.json',
                            'dprint.jsonc',
                            '.dprint.json',
                            '.dprint.jsonc',
                        },
                        url = 'https://dprint.dev/schemas/v0.json',
                    },
                },
            },
        },
    }
    lspconfig['jsonls'].setup(opts)
end

return M



--- note: yamlls settings
-- yamlls = {
--     settings = {
--         yaml = {
--             -- Schemas https://www.schemastore.org
--             schemas = {
--                 ['http://json.schemastore.org/gitlab-ci.json'] = { '.gitlab-ci.yml' },
--                 ['https://json.schemastore.org/bamboo-spec.json'] = {
--                     'bamboo-specs/*.{yml,yaml}',
--                 },
--                 ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = {
--                     'docker-compose*.{yml,yaml}',
--                 },
--                 ['http://json.schemastore.org/github-workflow.json'] = '.github/workflows/*.{yml,yaml}',
--                 ['http://json.schemastore.org/github-action.json'] = '.github/action.{yml,yaml}',
--                 ['http://json.schemastore.org/prettierrc.json'] = '.prettierrc.{yml,yaml}',
--                 ['http://json.schemastore.org/stylelintrc.json'] = '.stylelintrc.{yml,yaml}',
--                 ['http://json.schemastore.org/circleciconfig'] = '.circleci/**/*.{yml,yaml}',
--             },
--         },
--     },
-- },
