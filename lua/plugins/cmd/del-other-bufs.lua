vim.api.nvim_create_user_command('DeleteOtherBuffers', function()
    local curbuf = vim.api.nvim_get_current_buf()
    local bufs = vim.api.nvim_list_bufs()
    for _, buf in ipairs(bufs) do
        if buf ~= curbuf and vim.api.nvim_buf_is_loaded(buf) then
            vim.api.nvim_buf_delete(buf, {
                force = false,
                unload = false,
            })
        end
    end
end, {})

return {
    dir = vim.fn.stdpath('config') .. '/lua/plugins/cmd/del-other-bufs',
    keys = {
        { '<leader>bo', '<cmd>DeleteOtherBuffers<cr>', mode = { 'n' }, desc = 'Delete Other Buffers' },
    },
}
