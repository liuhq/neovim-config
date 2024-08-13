local root_pattern = require('lspconfig').util.root_pattern

local enable_lsp = {
    ['bashls'] = true,
    ['vtsls'] = true,
    ['jsonls'] = true,
    ['cssls'] = true,
    ['cssmodules_ls'] = false,
    ['html'] = true,
    ['lua_ls'] = true,
    ['markdown_oxide'] = true,
    ['marksman'] = true,
    ['rust_analyzer'] = true,
    ['taplo'] = true,
    ['yamlls'] = true,
    ['dprint'] = true,

}

---@param client vim.lsp.Client
---@param bufnr integer
local on_attach_base = function (client, bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Definition' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Declaration' })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Implementation' })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'References' })
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'Type Definition' })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover' })
    vim.keymap.set('n', '<C-i>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Help' })
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
        { buffer = bufnr, desc = 'Add Workspace Folder' })
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
        { buffer = bufnr, desc = 'Remove Workspace Folder' })
    vim.keymap.set('n', '<leader>wl', function ()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = bufnr, desc = 'List Workspace Folders' })
    ---- inc-rename instead
    vim.keymap.set('n', '<leader>cN', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Re[n]ame (LSP)' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
    vim.keymap.set('n', '<leader>cf', function ()
        vim.lsp.buf.format({ async = true })
    end, { buffer = bufnr, desc = 'Format (LSP)' })
    vim.keymap.set('n', '<leader>ai', '<cmd>LspInfo<cr>', { desc = 'LSP Info' })
    vim.keymap.set('n', '<leader>ch', function ()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
    end, { buffer = bufnr, desc = 'Toggle InlayHint' })

    ---- formatter
    vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()'

    ---- enable inlay hint
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end


---@type table<string,lspconfig.Config>
local lsp = {
    ['bashls'] = {
        enabled = enable_lsp['bashls'],
        on_attach = on_attach_base,
    },
    -- JS/TS, JSX/TSX, JSON/JSONC
    ['vtsls'] = {
        enabled = enable_lsp['vtsls'],
        cmd = { 'vtsls', '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        root_dir = root_pattern('tsconfig.json', 'package.json', 'jsconfig.json', '.git'),
        single_file_support = true,
        settings = {
            vtsls = {
                autoUseWorkspaceTsdk = true,
                enableMoveToFileCodeAction = true,
                experimental = {
                    completion = {
                        enableServerSideFuzzyMatch = true,
                    },
                },
                javascript = {
                    format = {
                        convertTabsToSpaces = true,
                        indentSize = 4,
                        trimTrailingWhitespace = true,
                    },
                },
                typescript = {
                    format = {
                        convertTabsToSpaces = true,
                        indentSize = 4,
                        trimTrailingWhitespace = true,
                    },
                },
            },
            javascript = {
                preferGoToSourceDefinition = true,
                suggest = {
                    completeFunctionCalls = true,
                },
                inlayHints = {
                    variableTypes = {
                        enabled = true,
                    },
                    propertyDeclarationTypes = {
                        enabled = true,
                    },
                    functionLikeReturnTypes = {
                        enabled = true,
                    },
                },
                format = {
                    enable = true,
                    insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = true,
                    semicolons = 'remove',
                },
                preferences = {
                    quoteStyle = 'single',
                },
                updateImportsOnFileMove = {
                    enabled = 'always',
                },
            },
            typescript = {
                preferGoToSourceDefinition = true,
                suggest = {
                    completeFunctionCalls = true,
                },
                inlayHints = {
                    variableTypes = {
                        enabled = true,
                    },
                    propertyDeclarationTypes = {
                        enabled = true,
                    },
                    functionLikeReturnTypes = {
                        enabled = true,
                    },
                },
                format = {
                    enable = true,
                    insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = true,
                    semicolons = 'remove',
                },
                preferences = {
                    quoteStyle = 'single',
                },
                updateImportsOnFileMove = {
                    enabled = 'always',
                },
                tsserver = {
                    maxTsServerMemory = 3072, -- 8192 on large repo
                    --pluginPaths = ['./node_modules'] -- if ts plugins not activated in project local folder
                },
            },
        },
        on_attach = function (client, bufnr)
            on_attach_base(client, bufnr)

            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end,
    },
    ['jsonls'] = {
        enabled = enable_lsp['jsonls'],
        on_attach = on_attach_base,
    },
    ['cssls'] = {
        enabled = enable_lsp['cssls'],
        on_attach = on_attach_base,
    },
    ['cssmodules_ls'] = {
        enabled = enable_lsp['cssmodules_ls'],
        on_attach = on_attach_base,
    },
    ['html'] = {
        enabled = enable_lsp['html'],
        on_attach = on_attach_base,
    },
    ['lua_ls'] = {
        enabled = enable_lsp['lua_ls'],
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_dir = root_pattern('.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml',
            'selene.toml', 'selene.yml', '.git'),
        single_file_support = true,
        on_init = function (client, _)
            local path = client.workspace_folders[1].name
            ---@diagnostic disable-next-line: undefined-field
            if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                return
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';'),
                },
                workspace = {
                    checkThirdParty = false,
                    library = vim.api.nvim_get_runtime_file('', true),
                },
            })
        end,
        settings = {
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = 'space',
                    indent_size = '4',
                    quote_style = 'single',
                    call_arg_parentheses = 'keep',
                    continuation_indent = '4',
                    max_line_length = '120',
                    end_of_line = 'lf',
                    trailing_table_separator = 'smart',
                    space_around_table_field_list = 'true',
                    align_call_args = 'false',
                    align_function_params = 'false',
                    align_continuous_assign_statement = 'false',
                    align_continuous_rect_table_field = 'false',
                    align_array_table = 'false',
                },
            },
            Lua = {},
        },
        on_attach = on_attach_base,
    },
    ['markdown_oxide'] = {
        enabled = enable_lsp['markdown_oxide'],
        on_attach = on_attach_base,
    },
    ['marksman'] = {
        enabled = enable_lsp['marksman'],
        on_attach = on_attach_base,
    },
    ['rust_analyzer'] = {
        enabled = enable_lsp['rust_analyzer'],
        on_attach = on_attach_base,
    },
    ['taplo'] = {
        enabled = enable_lsp['taplo'],
        on_attach = on_attach_base,
    },
    ['yamlls'] = {
        enabled = enable_lsp['yamlls'],
        on_attach = on_attach_base,
    },
    -- Formatter dprint
    ['dprint'] = {
        enabled = enable_lsp['dprint'],
        cmd = { 'dprint', 'lsp' },
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json', 'jsonc', 'markdown', 'python', 'toml', 'rust', 'roslyn' },
        root_dir = root_pattern('dprint.json', 'dprint.jsonc', '.dprint.json', '.dprint.jsonc', 'package.json', '.git'),
        single_file_support = true,
        settings = {},
        on_attach = on_attach_base,
    },
}

return lsp
