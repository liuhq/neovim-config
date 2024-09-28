local cursor_group = vim.api.nvim_create_augroup('CursorGroup', { clear = true })
-- restore cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
    group = cursor_group,
    callback = function ()
        local line = vim.fn.line('\'"')
        if line > 1 and line <= vim.fn.line('$') then
            vim.cmd.normal('g\'"')
        end
    end,
})

-- VimLeave * set guicursor= | call chansend(v:stderr, "\x1b[ q")
vim.api.nvim_create_autocmd('VimLeave', {
    group = cursor_group,
    callback = function ()
        vim.o.guicursor = ''
        vim.fn.chansend(vim.v.stderr, '\x1b[ q')
    end,
})

-- highlight after copy
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('YankHighlightGroup', { clear = true }),
    callback = function ()
        vim.highlight.on_yank({
            timeout = 100,
        })
    end,
})

-- Stop LSP client when leave nvim
vim.api.nvim_create_autocmd('VimLeave', {
    group = vim.api.nvim_create_augroup('lspconfig', { clear = false }),
    callback = function ()
        vim.lsp.stop_client(vim.lsp.get_clients())
    end,
})

-- Mason bin path
local mason_bin = vim.fn.stdpath('data') .. '/mason/bin'
---@diagnostic disable-next-line: undefined-field
local path_sep = vim.uv.os_uname().sysname == 'Windows_NT' and ';' or ':'
vim.env.PATH = mason_bin .. path_sep .. vim.env.PATH
vim.api.nvim_create_autocmd('VimLeave', {
    group = vim.api.nvim_create_augroup('MasonGroup', { clear = true }),
    callback = function ()
        vim.env.PATH = vim.env.PATH:gsub(mason_bin .. path_sep, '')
    end,
})
