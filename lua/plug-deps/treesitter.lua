return function ()
    MiniDeps.add({
        source = 'nvim-treesitter/nvim-treesitter',
        -- Use 'master' while monitoring updates in 'main'
        checkout = 'master',
        monitor = 'main',
        -- Perform action after every checkout
        hooks = { post_checkout = function () vim.cmd('TSUpdate') end },
    })

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

    require('nvim-treesitter.install').prefer_git = false
    require('nvim-treesitter.install').compilers = { 'gcc', 'zig' }
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup({
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
    })

    --- PERF: add nvim-treesitter custom query predicates early
    require('nvim-treesitter.query_predicates')

    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

    MiniDeps.add({
        source = 'nvim-treesitter/nvim-treesitter-textobjects',
        depends = { 'nvim-treesitter' },
    })

    MiniDeps.add({
        source = 'windwp/nvim-ts-autotag',
        depends = { 'nvim-treesitter' },
    })
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-ts-autotag').setup({
        opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = true,
        },
    })
end
