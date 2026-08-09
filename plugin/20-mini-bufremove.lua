vim.pack.add({ 'https://github.com/nvim-mini/mini.bufremove' })

require('mini.bufremove').setup()

vim.keymap.set('n', '<leader>x', function()
  MiniBufremove.delete()
end, { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>X', function()
  --- will remove everything related to the buffer
  MiniBufremove.wipeout()
end, { desc = 'Wipeout buffer (really delete)' })
