local M = {}

---@param on_attach_base fun(client:vim.lsp.Client, bufnr:integer)
function M.setup(on_attach_base)
    local lspconfig = require('lspconfig')
    local cmd_path = vim.fn.exepath('clangd')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    ---@type lspconfig.Config
    local opts = {
        enabled = true,
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
            on_attach_base(client, bufnr)
        end,
    }
    lspconfig['clangd'].setup(opts)
end

return M
