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
keymap.set({ 'n', 'v' }, '<M-v>', '"0p', { remap = false, silent = true })
keymap.set({ 'n', 'v' }, 'c', '"_c', { remap = false, silent = true })

-- better up/down
keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Cursor Down', expr = true, silent = true })
keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Cursor Up', expr = true, silent = true })

-- better jump to line start/end in visual mode
keymap.set('v', 'H', '^', { desc = 'Cursor Start (Visual)', remap = true, silent = true })
keymap.set('v', 'L', '$h', { desc = 'Cursor End (Visual)', remap = true, silent = true })

-- save file
keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- clear search with <esc>
-- keymap.set({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and Clear hlsearch' })

-- better indenting
keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')

-- quit
keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })
keymap.set('n', '<leader>qc', '<cmd>q<cr>', { desc = 'Quit Current' })
keymap.set('n', '<leader>qw', '<cmd>wq<cr>', { desc = 'Quit & Write' })

-- windows
keymap.set('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window', remap = true })
keymap.set('n', '<leader>ws', '<C-W>s', { desc = 'Split Window Below', remap = true })
keymap.set('n', '<leader>wv', '<C-W>v', { desc = 'Split Window Right', remap = true })

-- move to window using the <ctrl> hjkl keys
keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window', remap = true, silent = true })
keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window', remap = true, silent = true })
keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window', remap = true, silent = true })
keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window', remap = true, silent = true })

-- resize window using <ctrl> arrow keys
keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- buffers
keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
keymap.set('n', '<leader>bt', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
keymap.set('n', '<leader>d', '<cmd>bdelete<cr>', { desc = 'Delete Buffer' })

keymap.set('n', '<leader>ji', 'gi', { desc = 'Jump to Last Insert' })

keymap.set('n', '<leader>ab', function ()
    vim.o.background = vim.o.background == 'light' and 'dark' or 'light'
end, { desc = 'Change Background' })
