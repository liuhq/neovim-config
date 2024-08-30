local M = {}

local server_name = 'clangd'
local pkg_name = 'clangd'

function M.setup()
    local lspconfig = require('lspconfig')
    local lsp_set = require('plugins_native.lsp.set')
    local cmd_path = require('util').get_cmd_path('clangd')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = lsp_set.enable_pkg[pkg_name],
        cmd = { cmd_path },
        filetypes = {
            'c',
            'cpp',
            'objc',
            'objcpp',
            'cuda',
            'proto',
        },
        root_dir = lspconfig.util.root_pattern(
            '.clangd',
            '.clang-tidy',
            '.clang-format',
            'compile_commands.json',
            'compile_flags.txt',
            'configure.ac',
            '.git'),
        single_file_support = true,
        capabilities = capabilities,
        on_attach = function (client, bufnr)
            lsp_set.on_attach_base(client, bufnr)
        end,
    }
    lspconfig[server_name].setup(opts)
end

return M
