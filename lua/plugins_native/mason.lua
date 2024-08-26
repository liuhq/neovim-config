---Auto Mason Install
---@param list string[]
local auto_install = function (list)
    local mr = require('mason-registry')
    local mp = require('mason-core.package')
    local ntf = require('notify')
    local installend_pkg = mr.get_installed_package_names()

    mr:on(
        'package:uninstall:success',
        vim.schedule_wrap(function (pkg_spec)
            ntf(pkg_spec.name .. ' uninstalled successfully', vim.log.levels.INFO, { title = 'Mason AutoInstall' })
        end)
    )

    -- Install
    for _, server_name in ipairs(list) do
        local pkg_name, version = mp.Parse(server_name)

        if not mr.has_package(pkg_name) then
            ntf(pkg_name .. ' is not a valid LSP package name', vim.log.levels.ERROR, { title = 'Mason AutoInstall' })
            return
        end
        local pkg = mr.get_package(pkg_name)
        if not pkg:is_installed() then
            pkg:install({ version = version })
        end
    end

    -- Uninstall
    local diff_list = vim.fn.filter(installend_pkg, function (_, v)
        return vim.fn.index(list, v) == -1
    end)
    for _, server_name in ipairs(diff_list) do
        local pkg_name, _ = mp.Parse(server_name)
        local pkg = mr.get_package(pkg_name)
        if pkg:is_installed() then
            pkg:uninstall()
        end
    end

    ntf('run', vim.log.levels.INFO, { title = 'Mason AutoInstall' })
end

return {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = {
        { '<leader>am', '<cmd>Mason<cr>', desc = 'Mason' },
        {
            '<leader>ai',
            function ()
                vim.cmd('Mason')
                local lsp_list = require('plugins_native.lsp.set').enable_pkg
                local list = vim.tbl_keys(lsp_list)
                auto_install(list)
            end,
            desc = 'Mason AutoInstall',
        },
    },
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
