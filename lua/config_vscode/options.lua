-- encoding --
vim.g.encoding = 'UTF-8'
vim.o.fileencoding = 'UTF-8'

-- netrw disabled --
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- nvim options --
local opt = vim.opt

opt.autoindent = true
opt.clipboard = 'unnamedplus'
opt.completeopt = { 'menu', 'menuone', 'preview', 'noinsert', 'noselect' }
opt.confirm = true
opt.ignorecase = true
opt.incsearch = true
-- opt.showmode = false
opt.splitbelow = true
opt.splitright = true
opt.virtualedit = 'block'
