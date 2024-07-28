-- leader key --
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local keymap = vim.keymap

-- without yank --
-- keymap.set({ "n", "v" }, "d", '"_d')
-- keymap.set({ "n", "v" }, "p", '"_p')
-- keymap.set({ "n", "v" }, "P", '"_P')
-- keymap.set({ "n", "v" }, "c", '"_c')

-- better up/down
keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Cursor Down', expr = true, silent = true })
keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Cursor Down', expr = true, silent = true })
keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Cursor Up', expr = true, silent = true })
keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Cursor Up', expr = true, silent = true })

-- move Lines
keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Line Down' })
keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Line Up' })
keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Line Down' })
keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Line Up' })
keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Line Down' })
keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Line Up' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap.set('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
keymap.set('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
keymap.set('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
keymap.set('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
keymap.set('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
keymap.set('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- save file
keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- clear search with <esc>
keymap.set({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and Clear hlsearch' })

-- better indenting
keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')

-- quit
keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

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
keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete Buffer' })
