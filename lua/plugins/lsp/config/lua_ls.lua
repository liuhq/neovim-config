local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
---@param handlers table<string, lsp.Handler>
function M.setup(on_attach_base, handlers)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('lua-language-server')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
        cmd = { cmd_path },
        filetypes = { 'lua' },
        root_dir = lspconfig.util.root_pattern('.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml',
            'stylua.toml',
            'selene.toml', 'selene.yml', '.git'),
        single_file_support = true,
        capabilities = capabilities,
        on_init = function (client, _)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                ---@diagnostic disable-next-line: undefined-field
                if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
                    return
                end
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
        handlers = handlers,
    }

    lspconfig['lua_ls'].setup(opts)
end

return M
