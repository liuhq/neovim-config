vim.api.nvim_create_autocmd('VimEnter', {
    callback = function ()
        if vim.fn.argc() == 0 then
            require('mini.files').open(vim.fn.getcwd())
            vim.notify('Open in ' .. vim.fn.getcwd(), vim.log.levels.INFO)
        end
    end,
})

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

-- the cursor will redraw its shape when neovim is suspended or resumed
vim.api.nvim_create_autocmd('VimSuspend', {
    group = cursor_group,
    callback = function ()
        vim.o.guicursor = ''
        vim.fn.chansend(vim.v.stderr, '\x1b[ q')
        vim.cmd("silent !echo -ne '\\e[0 q'")
    end,
})
vim.api.nvim_create_autocmd('VimResume', {
    group = cursor_group,
    callback = function ()
        vim.o.guicursor = 'n-o:block,v-c:hor18,i-ci-ve:ver10,r-cr-sm:block,a:blinkwait700-blinkoff400-blinkon250'
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
