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
    -- Config --
    require('config_vscode/options')
    require('config_vscode/autocmds')
    require('config_vscode/keymaps')
    require('config/lazy')
    -- Colorscheme --
    vim.cmd.colorscheme = ''
end
