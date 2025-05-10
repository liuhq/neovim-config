# My neovim config

## Requirements

- Neovim `0.11+`
- a [Nerd Font](https://www.nerdfonts.com/) (currently using [Maple](https://github.com/subframe7536/maple-font))
- [`git`](https://git-scm.com/) and [`nodejs`](https://nodejs.org/)
- [`zig`](https://ziglang.org/) (be used as C compiler) for treesitter on Windows
- [`fd`](https://github.com/sharkdp/fd) and [`ripgrep`](https://github.com/BurntSushi/ripgrep)
- `unzip` for mason
- [`yazi`](https://yazi-rs.github.io/) for file browsing and managing

## Plugins list

Editor

- [mini.deps](https://github.com/echasnovski/mini.deps) : plugins manager
- [mason.nvim](https://github.com/williamboman/mason.nvim) : LSP manager
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) : treesitter support
- [yazi.nvim](https://github.com/mikavilpas/yazi.nvim) : file browser
- [conform.nvim](https://github.com/stevearc/conform.nvim) : formatter config
- [nvim-dap](https://github.com/mfussenegger/nvim-dap): DAP config
- [fzf-lua](https://github.com/ibhagwan/fzf-lua)
- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) : markdown render
- [mini.bufremove](https://github.com/echasnovski/mini.bufremove) : enhance buffers & windows

UI

- [catppuccin](https://github.com/catppuccin/nvim) : colorscheme
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) : buffers are displayed like as the tabline
- [fidget.nvim](https://github.com/j-hui/fidget.nvim) : notifications and LSP progress messages
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) : git integration UI
- [which-key.nvim](https://github.com/folke/which-key.nvim) : show keymap
- [mini.indentscope](https://github.com/echasnovski/mini.indentscope) : enhance indent display
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) : icon support
- [nui.nvim](https://github.com/echasnovski/mini.starter) : UI components backend

Coding

- [flash.nvim](https://github.com/folke/flash.nvim) : navigate code
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) : enhance completion
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip) : snippet engine
- [mini.ai](https://github.com/echasnovski/mini.ai) : enhance `a` / `i` textobjects
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) : enhance treesitter textobjects
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) : operate html tag by treesitter
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) : enhance pairs
- [nvim-surround](https://github.com/kylechui/nvim-surround) : operate surrounding delimiter pairs

## License

[BEERWARE](./LICENSE)
