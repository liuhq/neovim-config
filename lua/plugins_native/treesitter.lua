local ts_lang = {
    'bash',
    'c',
    'cpp',
    'css',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'racket',
    'rust',
    'toml',
    'tsx',
    'typescript',
    'xml',
}

return {
    'nvim-treesitter/nvim-treesitter',
    version = false, -- last release is way too old and doesn't work on Windows
    build = ':TSUpdate',
    event = 'BufReadPost',
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    opts = {
        ensure_installed = ts_lang,
        highlight = {
            enable = true,
            disable = function (_, bufnr) -- Disable in large buffers
                return vim.api.nvim_buf_line_count(bufnr) > 50000
            end,
        },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = 'gss',
                node_incremental = 'gsi',
                scope_incremental = 'gss',
                node_decremental = 'gsd',
            },
        },
        textobjects = {
            enable = true,
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    [']]'] = '@function.outer',
                    [']c'] = '@class.outer',
                },
                goto_next_end = {
                    [']['] = '@function.outer',
                    [']C'] = '@class.outer',
                },
                goto_previous_start = {
                    ['[['] = '@function.outer',
                    ['[c'] = '@class.outer',
                },
                goto_previous_end = {
                    ['[]'] = '@function.outer',
                    ['[C'] = '@class.outer',
                },
            },
        },
    },
    config = function (_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
}
