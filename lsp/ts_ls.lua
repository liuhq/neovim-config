---@brief
---
--- https://github.com/typescript-language-server/typescript-language-server
---
--- `ts_ls`, aka `typescript-language-server`
---
--- `typescript-language-server` depends on `typescript`. Both packages can be installed via `npm`:
--- ```sh
--- npm install -g typescript typescript-language-server
--- ```
---
---
--- Use the `:LspTypescriptSourceAction` command to see "whole file" ("source") code-actions such as:
--- - organize imports
--- - remove unused code
---

return {
    init_options = { hostInfo = 'neovim' },
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },
    root_markers = {
        'tsconfig.json',
        'jsconfig.json',
        'package.json',
        '.git',
    },
    single_file_support = true,
    handlers = {
        --- handle rename request for certain code actions like extracting functions / types
        -- ['_typescript.rename'] = function (_, result, ctx)
        --     local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
        --     vim.lsp.util.show_document({
        --         uri = result.textDocument.uri,
        --         range = {
        --             start = result.position,
        --             ['end'] = result.position,
        --         },
        --     }, client.offset_encoding)
        --     vim.lsp.buf.rename()
        --     return vim.NIL
        -- end,
    },
    on_attach = function (client, bufnr)
        --- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
        --- `vim.lsp.buf.code_action()` if specified in `context.only`.
        vim.api.nvim_buf_create_user_command(0, 'LspTypescriptSourceAction', function ()
            local source_actions = vim.tbl_filter(function (action)
                return vim.startswith(action, 'source.')
            end, client.server_capabilities.codeActionProvider.codeActionKinds)

            vim.lsp.buf.code_action({
                ---@diagnostic disable-next-line: missing-fields
                context = {
                    only = source_actions,
                },
            })
        end, {})
        vim.keymap.set('n', '<leader>cs', function ()
            vim.cmd('LspTypescriptSourceAction')
        end, { desc = 'Source Action', buffer = bufnr })
    end,
    settings = {
        javascript = {
            format = {
                semicolons = 'remove',
            },
            inlayHints = {
                functionLikeReturnTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true },
            },
            preferGoToSourceDefinition = true,
            preferences = {
                quoteStyle = 'single',
            },
        },
        typescript = {
            format = {
                semicolons = 'remove',
            },
            inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true },
            },
            preferGoToSourceDefinition = true,
            preferences = {
                preferTypeOnlyAutoImports = true,
                quoteStyle = 'single',
            },
            tsserver = {
                experimental = {
                    enableProjectDiagnostics = true,
                },
            },
        },
    },
}
