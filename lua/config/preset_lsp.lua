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

---@type table<string,lspconfig.Config>
local preset = {
    ['bashls'] = {
        enabled = enable_lsp['bashls'],
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
    },
    ['jsonls'] = {
        enabled = enable_lsp['jsonls'],
    },
    ['cssls'] = {
        enabled = enable_lsp['cssls'],
    },
    ['cssmodules_ls'] = {
        enabled = enable_lsp['cssmodules_ls'],
    },
    ['html'] = {
        enabled = enable_lsp['html'],
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
    },
    ['markdown_oxide'] = {
        enabled = enable_lsp['markdown_oxide'],
    },
    ['marksman'] = {
        enabled = enable_lsp['marksman'],
    },
    ['rust_analyzer'] = {
        enabled = enable_lsp['rust_analyzer'],
    },
    ['taplo'] = {
        enabled = enable_lsp['taplo'],
    },
    ['yamlls'] = {
        enabled = enable_lsp['yamlls'],
    },
    -- Formatter dprint
    ['dprint'] = {
        enabled = enable_lsp['dprint'],
        cmd = { 'dprint', 'lsp' },
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json', 'jsonc', 'markdown', 'python', 'toml', 'rust', 'roslyn' },
        root_dir = root_pattern('dprint.json', 'dprint.jsonc', '.dprint.json', '.dprint.jsonc', 'package.json', '.git'),
        single_file_support = true,
        settings = {},
    },
}

return preset
