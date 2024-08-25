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
