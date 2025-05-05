return function ()
    MiniDeps.add({ source = 'folke/flash.nvim' })

    require('flash').setup({
        jump = {
            autojump = true,
        },
    })

    vim.keymap.set({ 'n', 'x', 'o' }, '<CR>', function ()
        require('flash').jump()
    end, { desc = 'Flash' })
    vim.keymap.set({ 'n', 'x', 'o' }, '<S-CR>', function ()
        require('flash').treesitter()
    end, { desc = 'Flash Treesitter' })
end
