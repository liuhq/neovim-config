local ts_lang = {
    'bash',
    'css',
    'diff',
    'dot',
    'gitcommit',
    'html',
    'javascript',
    'json',
    'markdown',
    'markdown_inline',
    'racket',
    'regex',
    'rust',
    'toml',
    'tsx',
    'typescript',
}

return {
    'nvim-treesitter/nvim-treesitter',
    version = false, -- last release is way too old and doesn't work on Windows
    -- enabled = false,
    build = ':TSUpdate',
    event = 'BufReadPost',
    -- lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstallFromGrammar', 'TSInstall' },
    opts = {
        ensure_installed = ts_lang,
        highlight = {
            enable = true,
            disable = function (_, bufnr) -- Disable in large buffers
                return vim.api.nvim_buf_line_count(bufnr) > 50000
            end,
        },
        indent = { enable = true },
        incremental_selection = { enable = false },
        textobjects = { enable = false },
    },
    config = function (_, opts)
        require('nvim-treesitter.install').prefer_git = false
        require('nvim-treesitter.install').compilers = { 'zig' }
        require('nvim-treesitter.configs').setup(opts)

        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end,
}
