return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'cmp-nvim-lsp',
    },
    keys = {
        { '[d', vim.diagnostic.goto_prev, desc = 'Prev Diagnostic' },
        { ']d', vim.diagnostic.goto_next, desc = 'Next Diagnostic' },
        { '<leader>xl', vim.diagnostic.open_float, desc = 'Diagnostic List' },
        { '<leader>xa', vim.diagnostic.setloclist, desc = 'Mark Diagnostic' },
    },
    opts = {
        on_attach = function(_, bufnr) -- client, bufnr
            -- stylua: ignore start
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            vim.keymap.set('n', '<leader>jD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Declaration' })
            vim.keymap.set('n', '<leader>jd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Definition' })
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover' })
            vim.keymap.set('n', '<leader>ji', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Implementation' })
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Help' })
            vim.keymap.set( 'n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = 'Add Workspace Folder' })
            vim.keymap.set( 'n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = 'Remove Workspace Folder' })
            vim.keymap.set('n', '<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, { buffer = bufnr, desc = 'List Workspace Folders' })
            vim.keymap.set('n', '<leader>jt', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'Type Definition' })
            ---- inc-rename instead
            -- vim.keymap.set('n', '<leader>cN', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Re[n]ame LSP' })
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
            vim.keymap.set('n', '<leader>jr', vim.lsp.buf.references, { buffer = bufnr, desc = 'References' })
            vim.keymap.set('n', '<leader>cf', function()
                vim.lsp.buf.format({ async = true })
            end, { buffer = bufnr, desc = 'Format' })
            -- stylua: ignore end
        end,
    },
    config = function(_, opts)
        local lspconfig = require('lspconfig')
        local mason_lspconfig = require('mason-lspconfig')
        local preset = require('plugins.lsp.preset')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(preset.lsp) })
        mason_lspconfig.setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    on_attach = opts.on_attach,
                    -- settings = preset.lsp[server_name],
                })
            end,
        })
    end,
}
