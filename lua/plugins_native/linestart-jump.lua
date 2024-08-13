-- Line Start Jump (link vscode) --
vim.api.nvim_create_user_command('CursorToLineStart', function ()
    local head = (vim.api.nvim_get_current_line():find('[^%s]') or 1) - 1
    local cursor = vim.api.nvim_win_get_cursor(0)
    cursor[2] = cursor[2] == head and 0 or head
    vim.api.nvim_win_set_cursor(0, cursor)
end, {})

return {
    dir = vim.fn.stdpath('config') .. '/lua/plugins_native/linestart-jump',
    keys = {
        { '<Home>', '<cmd>CursorToLineStart<cr>', mode = { 'i', 'n' }, desc = 'Jump to Line Start' },
        { '0', '<cmd>CursorToLineStart<cr>', mode = 'n', desc = 'Jump to Line Start' },
    },
}
