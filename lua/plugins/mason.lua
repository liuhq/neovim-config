-- COMMENT is lspconfig server name
-- KEY is mason.nvim package name
local enable_pkg = {
    -- lsp: bashls and formatter: shfmt
    'bash-language-server',
    'shfmt',

    'clangd',
    -- cssls
    'css-lsp',
    -- dotls
    'dot-language-server',
    -- html
    'html-lsp',
    -- jsonls
    'json-lsp',
    -- lua_ls
    'lua-language-server',
    'marksman',
    -- rust_analyzer
    'rust-analyzer',
    -- tailwindcss
    'tailwindcss-language-server',
    'taplo',
    'vtsls',

    --- DAP
    'codelldb',
    'js-debug-adapter',

    --- Formatter
    'dprint',
    'prettier',
}

---Auto Mason Install
---@param list string[]
local auto_install = function (list)
    local mr = require('mason-registry')
    local mp = require('mason-core.package')
    local installend_pkg = mr.get_installed_package_names()

    mr:on(
        'package:uninstall:success',
        vim.schedule_wrap(function (pkg_spec)
            vim.notify(pkg_spec.name .. ' uninstalled successfully', vim.log.levels.INFO, { group = 'Mason AutoInstall' })
        end)
    )

    -- Install
    for _, server_name in ipairs(list) do
        local pkg_name, version = mp.Parse(server_name)

        if not mr.has_package(pkg_name) then
            vim.notify(pkg_name .. ' is not a valid LSP package name', vim.log.levels.ERROR, { group = 'Mason AutoInstall' })
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

    vim.notify('run', vim.log.levels.INFO, { group = 'Mason AutoInstall' })
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
                auto_install(enable_pkg)
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
