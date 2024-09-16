-- Checkhealth advice to disable
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
-- netrw disabled --
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

if not vim.g.vscode then
    -- ordinary Neovim
    -- Config --
    require('config/options')
    require('config/autocmds')
    require('config/keymaps')
    require('config/lazy')
    -- Colorscheme --
    vim.cmd.colorscheme('catppuccin')
else
    -- VSCode extension
    require('config/vscode')
    require('config/lazy')
end
