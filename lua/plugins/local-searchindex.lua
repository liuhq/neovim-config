M = {}

vim.opt.shortmess:append({ S = true, s = true })

local search_count_extmark_id = nil

M.show_search_index = function ()
    vim.schedule(function ()
        local searchCount = vim.fn.searchcount()
        if (not searchCount) or (not searchCount.total) or searchCount.total == 0 then
            M.clear_search_index()
            return
        end

        local search_str = vim.fn.getreg('/'):gsub('\\<', ''):gsub('\\>', '')
        local namespaceId = vim.api.nvim_create_namespace('search')
        vim.api.nvim_buf_clear_namespace(0, namespaceId, 0, -1)
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        line = line - 1

        search_count_extmark_id = vim.api.nvim_buf_set_extmark(0, namespaceId, line, col, {
            virt_text = { { '  <- ' .. search_str .. ' [' .. searchCount.current .. '/' .. searchCount.total .. ']', 'DiagnosticVirtualTextInfo' } },
            virt_text_pos = 'eol',
        })

        vim.cmd('redraw')
    end)
end

M.clear_search_index = function ()
    local namespaceId = vim.api.nvim_get_namespaces()['search']
    if namespaceId and search_count_extmark_id then
        vim.api.nvim_buf_del_extmark(0, namespaceId, search_count_extmark_id)
        vim.cmd('redraw')
    end
end

--- fix auto callback when press <esc>
local cmd_esc = false
local searchindex_gp = vim.api.nvim_create_augroup('SearchIndex', { clear = true })
vim.api.nvim_create_autocmd('CmdlineEnter', {
    group = searchindex_gp,
    pattern = { '/', '?' },
    callback = function (e)
        if e.match == '/' or e.match == '?' then
            vim.on_key(function (key, _)
                key = vim.fn.keytrans(key)
                if key == '<Esc>' then
                    cmd_esc = true
                end
            end, vim.api.nvim_get_namespaces()['search'])
        end
    end,
})
vim.api.nvim_create_autocmd('CmdlineLeave', {
    group = searchindex_gp,
    pattern = { '/', '?' },
    callback = function (e)
        if e.match == '/' or e.match == '?' then
            if vim.fn.searchcount().total ~= 0 and (not cmd_esc) then
                M.show_search_index()
            end
            cmd_esc = false
            vim.on_key(nil, vim.api.nvim_get_namespaces()['search'])
        end
    end,
})

return {
    dir = vim.fn.stdpath('config') .. '/lua/plugins/local-searchindex',
    keys = {
        {
            '<esc>',
            function ()
                vim.cmd('noh')
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
                M.clear_search_index()
            end,
            mode = { 'n', 'i' },
            desc = 'Escape and Clear hlsearch',
        },
        {
            'n',
            function ()
                -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
                vim.api.nvim_feedkeys(vim.v.searchforward == 1 and 'n' or 'N' .. 'zv', 'n', false)
                M.show_search_index()
            end,
            mode = { 'n' },
            desc = 'Next Search',
        },
        {
            'n',
            function ()
                vim.api.nvim_feedkeys(vim.v.searchforward == 1 and 'n' or 'N', 'n', false)
                M.show_search_index()
            end,
            mode = { 'x', 'o' },
            desc = 'Next Search',
        },
        {
            'N',
            function ()
                vim.api.nvim_feedkeys(vim.v.searchforward == 1 and 'N' or 'n' .. 'zv', 'n', false)
                M.show_search_index()
            end,
            mode = { 'n' },
            desc = 'Prev Search',
        },
        {
            'N',
            function ()
                vim.api.nvim_feedkeys(vim.v.searchforward == 1 and 'N' or 'n', 'n', false)
                M.show_search_index()
            end,
            mode = { 'x', 'o' },
            desc = 'Prev Search',
        },
        {
            '*',
            function ()
                vim.api.nvim_feedkeys('*', 'n', false)
                M.show_search_index()
            end,
            mode = { 'n' },
            desc = 'Next Search under Cursor',
        },
        {
            '#',
            function ()
                vim.api.nvim_feedkeys('#', 'n', false)
                M.show_search_index()
            end,
            mode = { 'n' },
            desc = 'Prev Search under Cursor',
        },
        {
            'g*',
            function ()
                vim.api.nvim_feedkeys('g*', 'n', false)
                M.show_search_index()
            end,
            mode = { 'n' },
            desc = 'Next Search under Cursor (Fuzzy)',
        },
        {
            'g#',
            function ()
                vim.api.nvim_feedkeys('g#', 'n', false)
                M.show_search_index()
            end,
            mode = { 'n' },
            desc = 'Prev Search under Cursor (Fuzzy)',
        },
    },
}
