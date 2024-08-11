-- onsails/lspkind.nvim
-- folke/trouble.nvim
-- lewis6991/gitsigns.nvim

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

vim.keymap.set('n', '<leader>al', '<cmd>Lazy<cr>', { desc = 'Lazy' })

require('lazy').setup({
    spec = {
        { import = 'plugins' },
    },
    defaults = {
        lazy = false,
        version = false,
    },
    install = { colorscheme = { 'catppuccin' } },
    checker = { enabled = true },
    ui = {
        size = { width = 0.8, height = 0.8 },
        wrap = true,
        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = 'solid',
        -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
        backdrop = 0,
        title = 'Lazy Dashboard',
        title_pos = 'left', -- "center" | "left" | "right"
        pills = true,
    },
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                'gzip',
                'netrwPlugin',
                'osc52',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
})
