-- encoding --
vim.g.encoding = 'UTF-8'
vim.o.fileencoding = 'UTF-8'

-- netrw disabled --
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- colorscheme --
vim.cmd.colorscheme()

-- notify
vim.notify = require('vscode').notify

--[[
--  Options
--]]
local o = vim.o

o.autoindent = true
o.clipboard = 'unnamedplus'
o.completeopt = 'menu,menuone,preview,noinsert,noselect'
o.confirm = true
o.ignorecase = true
o.incsearch = true
o.splitbelow = true
o.splitright = true
o.virtualedit = 'block'

--[[
--  Autocmds
--]]
-- restore cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function ()
        local line = vim.fn.line('\'"')
        if line > 1 and line <= vim.fn.line('$') then
            vim.cmd.normal('g\'"')
        end
    end,
})

-- highlight after copy
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function ()
        vim.highlight.on_yank({
            timeout = 100,
        })
    end,
})

--[[
--  Keymaps
--]]
-- leader key --
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local keymap = vim.keymap

--[[
--  Note:
--      1. ! - run program
--      2. @ - call the macro records
--      3. */# - search backward/forward for the word under the cursor
--      4. % - jump between surround
--]]

-- without yank --
keymap.set('v', 'd', '"_d', { remap = false, silent = true })
keymap.set({ 'n', 'v' }, 'c', '"_c', { remap = false, silent = true })

-- better up/down
keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Cursor Down', expr = true, silent = true })
keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Cursor Down', expr = true, silent = true })
keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Cursor Up', expr = true, silent = true })
keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Cursor Up', expr = true, silent = true })

-- better jump to line start/end in visual mode
keymap.set('v', 'H', '^', { desc = 'Cursor Start (Visual)', remap = true, silent = true })
keymap.set('v', 'L', '$h', { desc = 'Cursor End (Visual)', remap = true, silent = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap.set('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
keymap.set('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
keymap.set('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
keymap.set('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
keymap.set('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
keymap.set('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- clear search with <esc>
keymap.set({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and Clear hlsearch' })

-- better indenting
keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')

-- remap gi
keymap.set('n', '<leader>ji', 'gi', { desc = 'Jump to Last Insert' })
