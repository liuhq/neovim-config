local icons = _G.ConfigUtil.icons
local lsp_config_group = vim.api.nvim_create_augroup('LspConfig', { clear = true })
local borders = {
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
}

--- unset some default LSP keymap
vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'grn')

vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_config_group,
    callback = function (args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method('textDocument/codeAction') then
            vim.keymap.set({ 'n', 'v' }, 'ga', vim.lsp.buf.code_action,
                { desc = 'Code Action', buffer = args.buf })
        end
        if client:supports_method('textDocument/declaration') then
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Declaration', buffer = args.buf })
        end
        if client:supports_method('textDocument/definition') then
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Definition', buffer = args.buf })
        end
        if client:supports_method('textDocument/foldingRange') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldmethod = 'expr'
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'

            vim.keymap.set('n', '<leader>fz', function ()
                vim.lsp.foldclose('imports', vim.fn.bufwinid(0))
            end, { desc = 'Fold Imports Quickly', buffer = args.buf })
        end
        if client:supports_method('textDocument/formatting') then
            vim.bo[args.buf].formatexpr = 'v:lua.vim.lsp.formatexpr(#{timeout_ms:250})'
            vim.keymap.set({ 'n', 'v' }, 'g+', function ()
                vim.lsp.buf.format({ async = true })
            end, { desc = 'Format (LSP)', buffer = args.buf })
        end
        if client:supports_method('textDocument/hover') then
            vim.keymap.set('n', 'gh', function ()
                vim.lsp.buf.hover({ border = borders })
            end, { desc = 'LSP Help', buffer = args.buf })
        end
        if client:supports_method('textDocument/implementation') then
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Implementation', buffer = args.buf })
        end
        if client:supports_method('textDocument/inlayHint') then
            vim.keymap.set('n', '<leader>ch', function ()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
            end, { desc = 'Toggle InlayHint', buffer = args.buf })
        end
        if client:supports_method('textDocument/references') then
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'References', buffer = args.buf })
        end
        if client:supports_method('textDocument/rename') then
            vim.keymap.set('n', 'gn', vim.lsp.buf.rename, { desc = 'Rename', buffer = args.buf })
        end
        if client:supports_method('textDocument/signatureHelp') then
            -- <C-S> is also mapped in insert mode to vim.lsp.buf.signature_help()
            vim.keymap.set('n', 'gs', function ()
                vim.lsp.buf.signature_help({
                    border = borders,
                    title_pos = 'left',
                })
            end, { desc = 'Signature Help', buffer = args.buf })
        end
        if client:supports_method('textDocument/typeDefinition*') then
            vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Type Definition', buffer = args.buf })
        end

        if client:supports_method('workspace/workspaceFolders') then
            vim.keymap.set('n', '<leader>fa', vim.lsp.buf.add_workspace_folder,
                { desc = 'Add Workspace Folder', buffer = args.buf })
            vim.keymap.set('n', '<leader>fr', vim.lsp.buf.remove_workspace_folder,
                { desc = 'Remove Workspace Folder', buffer = args.buf })
            vim.keymap.set('n', '<leader>fl', function ()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, { desc = 'List Workspace Folders', buffer = args.buf })
        end

        if client:supports_method('textDocument/publishDiagnostics') then
            vim.diagnostic.config({
                virtual_text = {
                    prefix = icons.diagnostics.Sign,
                    virt_text_pos = 'eol_right_align',
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
                        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                        [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
                        [vim.diagnostic.severity.WARN] = 'WarningMsg',
                    },
                },
                float = {
                    scope = 'line',
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    border = borders,
                },
                update_in_insert = true,
                severity_sort = true,
            }, vim.lsp.diagnostic.get_namespace(args.data.client_id))

            vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Diagnostic Info', buffer = args.buf })
            vim.keymap.set('n', '<leader>dh', function ()
                vim.notify(vim.diagnostic.is_enabled({ bufnr = 0 })
                    and 'Diagnostic: disabled'
                    or 'Diagnostic: enabled',
                    vim.log.levels.INFO,
                    { group = 'Diagnostic Show', skip_history = true })
                vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
            end, { desc = 'Toggle Diagnostic', buffer = args.buf })
        end

        vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        -- vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = false })
    end,
})

-- Stop LSP client when leave nvim
vim.api.nvim_create_autocmd('VimLeave', {
    group = lsp_config_group,
    callback = function ()
        vim.lsp.stop_client(vim.lsp.get_clients())
    end,
})

--- wait for lsp command: https://github.com/neovim/nvim-lspconfig/pull/3734

vim.lsp.config('*', {
    root_markers = { '.git' },
})

vim.lsp.enable({
    'bashls',
    'clangd',
    'cssls',
    'dotls',
    'html',
    'jsonls',
    'lua_ls',
    'marksman',
    -- 'nixd',
    'racket_langserver',
    'rust_analyzer',
    'tailwindcss',
    'taplo',
    'ts_ls',
    'yamlls',
})
