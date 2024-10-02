local icons = require('util').icons

---@param client vim.lsp.Client
---@param bufnr integer
local on_attach_base = function (client, bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Definition' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Declaration' })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Implementation' })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'References' })
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'Type Definition' })
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP Help' })
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Help' })
    vim.keymap.set('n', '<leader>za', vim.lsp.buf.add_workspace_folder,
        { buffer = bufnr, desc = 'Add Workspace Folder' })
    vim.keymap.set('n', '<leader>zr', vim.lsp.buf.remove_workspace_folder,
        { buffer = bufnr, desc = 'Remove Workspace Folder' })
    vim.keymap.set('n', '<leader>zl', function ()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = bufnr, desc = 'List Workspace Folders' })
    ---- inc-rename instead
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
    vim.keymap.set('n', '<leader>cF', function ()
        vim.lsp.buf.format({ async = true })
    end, { buffer = bufnr, desc = 'Format (LSP)' })
    vim.keymap.set('n', '<leader>ch', function ()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
    end, { buffer = bufnr, desc = 'Toggle InlayHint' })

    ---- formatter
    -- vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()'

    ---- enable inlay hint
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

local border = {
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
}

local handlers = {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'cmp-nvim-lsp', 'nvim-navic' },
    keys = {
        { '[d', vim.diagnostic.goto_prev, desc = 'Prev Diagnostic' },
        { ']d', vim.diagnostic.goto_next, desc = 'Next Diagnostic' },
        { '<leader>xi', vim.diagnostic.open_float, desc = 'Diagnostic Info' },
        { '<leader>xm', vim.diagnostic.setloclist, desc = 'Mark Diagnostic' },
        { '<leader>al', '<cmd>LspInfo<cr>', desc = 'LSP Info' },
        {
            '<leader>xh',
            function ()
                vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
            end,
            desc = 'Toggle Virtual Text',
        },
    },
    config = function ()
        require('plugins.lsp.config.bashls').setup(on_attach_base, handlers)
        require('plugins.lsp.config.clangd').setup(on_attach_base, handlers)
        require('plugins.lsp.config.cssls').setup(on_attach_base, handlers)
        require('plugins.lsp.config.dotls').setup(on_attach_base, handlers)
        require('plugins.lsp.config.html').setup(on_attach_base, handlers)
        require('plugins.lsp.config.jsonls').setup(on_attach_base, handlers)
        require('plugins.lsp.config.lua_ls').setup(on_attach_base, handlers)
        require('plugins.lsp.config.marksman').setup(on_attach_base, handlers)
        require('plugins.lsp.config.rust_analyzer').setup(on_attach_base, handlers)
        require('plugins.lsp.config.tailwindcss').setup(on_attach_base, handlers)
        require('plugins.lsp.config.taplo').setup(on_attach_base, handlers)
        require('plugins.lsp.config.vtsls').setup(on_attach_base, handlers)

        vim.diagnostic.config({
            severity_sort = true,
            float = {
                scope = 'line',
                ---@diagnostic disable-next-line: assign-type-mismatch
                border = border,
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                    [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
                    [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                    [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
                },
                numhl = {
                    [vim.diagnostic.severity.WARN] = 'WarningMsg',
                    [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
                },
            },
            virtual_text = {
                prefix = icons.diagnostics.Sign,
                virt_text_pos = 'right_align',
            },
        })

        require('lspconfig.ui.windows').default_options.border = {
            { '┌', 'NormalFloat' },
            { '─', 'NormalFloat' },
            { '┐', 'NormalFloat' },
            { '│', 'NormalFloat' },
            { '┘', 'NormalFloat' },
            { '─', 'NormalFloat' },
            { '└', 'NormalFloat' },
            { '│', 'NormalFloat' },
        }
    end,
}