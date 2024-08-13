local ts_lang = {
    'bash',
    'c',
    'comment',
    'cpp',
    'css',
    'csv',
    'diff',
    'glsl',
    'graphql',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'jsonc',
    'jsonnet',
    'kdl',
    'lua',
    'luadoc',
    'luap',
    'markdown',
    'markdown_inline',
    'printf',
    'racket',
    'regex',
    'rust',
    'sql',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'xml',
    'yaml',
}

return {
    'nvim-treesitter/nvim-treesitter',
    version = false, -- last release is way too old and doesn't work on Windows
    build = ':TSUpdate',
    event = 'BufReadPost',
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    -- init = function(plugin)
    --     -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    --     -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    --     -- no longer trigger the **nvim-treesitter** module to be loaded in time.
    --     -- Luckily, the only things that those plugins need are the custom queries, which we make available
    --     -- during startup.
    --     require('lazy.core.loader').add_to_rtp(plugin)
    --     require('nvim-treesitter.query_predicates')
    -- end,
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
        -- textobjects = {
        --     enable = true,
        --     -- stylua: ignore
        --     select = {
        --         enable = true,
        --         lookahead = true,
        --         keymaps = {
        --             ['<leader>aa'] = '@parameter.outer',
        --             ['<leader>ia'] = '@parameter.inner',
        --             ['<leader>af'] = '@function.outer',
        --             ['<leader>if'] = '@function.inner',
        --             ['<leader>ac'] = '@class.outer',
        --             ['<leader>ic'] = '@class.inner',
        --         },
        --     },
        --     -- stylua: ignore
        --     move = {
        --         enable = true,
        --         goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
        --         goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
        --         goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner', },
        --         goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
        --     },
        -- },
    },
    config = function (_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
}
