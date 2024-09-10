local M = {}

-- COMMENT is lspconfig server name
-- KEY is mason.nvim package name
M.enable_pkg = {
    -- bashls
    ['bash-language-server'] = true,
    ['clangd'] = true,
    -- cssls
    ['css-lsp'] = true,
    -- dotls
    ['dot-language-server'] = true,
    ['dprint'] = true,
    -- html
    ['html-lsp'] = true,
    -- jsonls
    ['json-lsp'] = true,
    -- lua_ls
    ['lua-language-server'] = true,
    ['marksman'] = true,
    -- rust_analyzer
    ['rust-analyzer'] = true,
    --- bash formatter: shfmt
    ['shfmt'] = true,
    -- tailwindcss
    ['tailwindcss-language-server'] = true,
    ['taplo'] = true,
    ['vtsls'] = true,
}

---@param client vim.lsp.Client
---@param bufnr integer
function M.on_attach_base(client, bufnr)
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
    vim.keymap.set('n', '<leader>al', '<cmd>LspInfo<cr>', { desc = 'LSP Info' })
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

return M
