local ts_lang = {
    'astro',
    'bash',
    'c',
    'caddy',
    'commonlisp',
    'cpp',
    'css',
    'diff',
    'dockerfile',
    'dot',
    'git_rebase',
    'gitcommit',
    'glsl',
    'go',
    'graphql',
    'html',
    'ini',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'jsonc',
    'just',
    'lua',
    'markdown',
    'markdown_inline',
    'nix',
    'python',
    'regex',
    'rust',
    'sql',
    'toml',
    'tsx',
    'typescript',
    'wgsl',
    'xml',
    'yaml',
}

return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = 'VeryLazy',
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
        init = function (plugin)
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treesitter** module to be loaded in time.
            -- Luckily, the only things that those plugins need are the custom queries, which we make available
            -- during startup.
            require('lazy.core.loader').add_to_rtp(plugin)
            require('nvim-treesitter.query_predicates')
        end,
        cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstallFromGrammar', 'TSInstall' },
        ---@type TSConfig
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            ensure_installed = ts_lang,
            sync_install = true,
            highlight = {
                enable = true,
                disable = function (_, bufnr) -- Disable in large buffers
                    return vim.api.nvim_buf_line_count(bufnr) > 50000
                end,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<leader>sn',
                    node_incremental = '<space>',
                    scope_incremental = false,
                    node_decremental = '<bs>',
                },
            },
            textobjects = {
                move = {
                    enable = true,
                    goto_next_start = { [']f'] = '@function.outer' },
                    goto_next_end = { [']F'] = '@function.outer' },
                    goto_previous_start = { ['[f'] = '@function.outer' },
                    goto_previous_end = { ['[F'] = '@function.outer' },
                },
            },
        },
        config = function (_, opts)
            require('nvim-treesitter.install').prefer_git = false
            require('nvim-treesitter.install').compilers = { 'gcc', 'zig' }
            require('nvim-treesitter.configs').setup(opts)

            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter' },
        event = 'VeryLazy',
    },
    {
        'windwp/nvim-ts-autotag',
        dependencies = { 'nvim-treesitter' },
        event = 'InsertEnter',
        config = function ()
            require('nvim-ts-autotag').setup({
                opts = {
                    enable_close = true,
                    enable_rename = true,
                    enable_close_on_slash = true,
                },
            })
        end,
    },
}
