-- restore cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        local line = vim.fn.line('\'"')
        if line > 1 and line <= vim.fn.line('$') then
            vim.cmd.normal('g\'"')
        end
    end,
})

-- VimLeave * set guicursor= | call chansend(v:stderr, "\x1b[ q")
vim.api.nvim_create_autocmd('VimLeave', {
    pattern = '*',
    callback = function()
        vim.o.guicursor = ''
        vim.fn.chansend(vim.v.stderr, '\x1b[ q')
    end,
})

-- highlight after copy
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            timeout = 300,
        })
    end,
})
