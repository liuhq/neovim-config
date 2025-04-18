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
keymap.set({ 'n', 'v' }, '<M-V>', '"0p', { remap = false, silent = true })
keymap.set({ 'n', 'v' }, 'c', '"_c', { remap = false, silent = true })

-- better up/down
keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Cursor Down', expr = true, silent = true })
keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Cursor Up', expr = true, silent = true })

-- better jump to line start/end
-- "jump to start" handled by local-linestart-jump in normal mode
-- keymap.set('n', 'H', '^', { desc = 'Cursor Start', remap = true, silent = true })
keymap.set('n', 'L', '$', { desc = 'Cursor End', remap = true, silent = true })
keymap.set('v', 'H', '^', { desc = 'Cursor Start', remap = true, silent = true })
keymap.set('v', 'L', '$h', { desc = 'Cursor End', remap = true, silent = true })

-- save file
keymap.set({ 'i', 'x', 'n', 's' }, '<leader><cr>', '<cmd>w<cr><esc>', { desc = 'Save File' })

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
keymap.set('n', '<C-H>', '<C-W>h', { desc = 'Go to Left Window', remap = true, silent = true })
keymap.set('n', '<C-J>', '<C-W>j', { desc = 'Go to Lower Window', remap = true, silent = true })
keymap.set('n', '<C-K>', '<C-W>k', { desc = 'Go to Upper Window', remap = true, silent = true })
keymap.set('n', '<C-L>', '<C-W>l', { desc = 'Go to Right Window', remap = true, silent = true })

-- resize window using <ctrl> arrow keys
keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- buffers
keymap.set('n', '{', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
keymap.set('n', '}', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
keymap.set('n', '<leader>t', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
---- handled by Snacks.bufdelete
-- keymap.set('n', '<leader>d', '<cmd>bdelete<cr>', { desc = 'Delete Buffer' })

keymap.set('n', '<leader>jj', 'gi', { desc = 'Jump to Last Insert' })

keymap.set({ 'n', 'v' }, 'K', 'i<cr><esc>', { remap = false, silent = true })
