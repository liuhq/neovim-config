local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_deps_path = path_package .. 'pack/deps/start/mini.deps'
local mini_deps_repo = 'https://github.com/echasnovski/mini.deps'

---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(mini_deps_path) then
    vim.cmd('echo "Installing `mini.deps`" | redraw')
    local clone_cmd = { 'git', 'clone', '--filter=blob:none', mini_deps_repo, mini_deps_path }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.deps | helptags ALL')
    vim.cmd('echo "Installed `mini.deps`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })

vim.keymap.set('n', '<leader>au', '<cmd>DepsUpdate<cr>', { desc = 'MiniDeps Update' })
vim.keymap.set('n', '<leader>aa', '<cmd>DepsShowLog<cr>', { desc = 'MiniDeps Log' })

local now, later = MiniDeps.now, MiniDeps.later

now(require('plug-deps.catppuccin'))
now(require('plug-deps.fidget'))
now(require('plug-deps.yazi'))
now(require('plug-deps.treesitter'))
now(require('plug-deps.nui'))
now(require('plug-deps.nvim-cmp'))
now(require('plug-deps.which-key'))

later(require('plug-deps.bufferline'))
later(require('plug-deps.mini-bufremove'))
later(require('plug-deps.conform'))
later(require('plug-deps.dap'))
later(require('plug-deps.flash'))
later(require('plug-deps.fzf-lua'))
later(require('plug-deps.gitsigns'))
later(require('plug-deps.mini-ai'))
later(require('plug-deps.mini-indentscope'))
later(require('plug-deps.nvim-autopairs'))
later(require('plug-deps.surround'))

require('plug-deps.mason')
