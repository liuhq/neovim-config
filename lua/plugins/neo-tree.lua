return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'plenary.nvim',
        'nvim-web-devicons',
        'nui.nvim',
    },
    lazy = false,
    keys = {
        {
            '<leader>e',
            '<cmd>Neotree toggle=true reveal=true<cr>',
            desc = 'Open Neotree (Current file)',
        },
        {
            '-',
            function ()
                local reveal_file = vim.fn.expand('%:p')
                if (reveal_file == '') then
                    reveal_file = vim.fn.getcwd()
                else
                    local f = io.open(reveal_file, 'r')
                    if (f) then
                        f.close(f)
                    else
                        reveal_file = vim.fn.getcwd()
                    end
                end
                require('neo-tree.command').execute({
                    reveal_file = reveal_file, -- path to file or folder to reveal
                    reveal_force_cwd = true,   -- change cwd without asking if needed
                })
            end,
            desc = 'Open Neotree (Current file or Working dir)',
        },
    },
    ---@type neotree.Config
    opts = {
        close_if_last_window = false,
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { 'help', 'terminal', 'trouble', 'qf' },
        filesystem = {
            hijack_netrw_behavior = 'open_default',
        },
        window = {
            position = 'float',
        },
        nesting_rules = {},
    },
}
