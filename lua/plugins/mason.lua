return {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>am', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    opts = {
        install_root_dir = vim.fn.stdpath('data') .. '/mason',
        PATH = 'prepend',
        ui = {
            check_outdated_packages_on_open = true,
            border = 'solid',
            width = 0.8,
            height = 0.8,
            icons = {
                package_installed = '✓',
                package_pending = '➜',
                package_uninstalled = '✗',
            },
        },
    },
}
