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
opt.cursorline = true
opt.expandtab = true
opt.fileformat = 'unix'
opt.fileformats = 'unix'
opt.fillchars = {
    foldopen = '',
    foldclose = '',
    fold = ' ',
    foldsep = ' ',
    diff = '╱',
    eob = ' ',
}
opt.foldlevel = 99
opt.guicursor = 'n:block,v-c:hor18,o:hor25,i-ci-ve:ver10,r-cr-sm:block,a:blinkwait700-blinkoff400-blinkon250'
opt.ignorecase = true
opt.incsearch = true
opt.laststatus = 3
opt.mouse = 'a'
opt.number = true
opt.numberwidth = 4
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
-- opt.ruler = true
-- opt.rulerformat = "%17(%p%%, %c%V%)"
opt.scrolljump = 1
opt.scrolloff = 5
opt.sessionoptions = { 'buffers', 'curdir', 'folds', 'globals', 'help', 'tabpages', 'winpos', 'winsize', 'terminal' }
opt.shiftround = true
opt.shiftwidth = 4
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.smartcase = true
opt.smartindent = true
opt.smoothscroll = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = 'block'
opt.wildmode = 'longest:full,full'
opt.winminwidth = 5
opt.wrap = false
opt.whichwrap = '<,>,[,]'
