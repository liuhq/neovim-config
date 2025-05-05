-- COMMENT is lspconfig server name
-- KEY is mason.nvim package name
local enable_pkg = {
    -- lsp: bashls and formatter: shfmt
    'bash-language-server',
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
    -- ts_ls
    'typescript-language-server',
    -- yamlls
    'yaml-language-server',

    --- DAP
    'codelldb',
    'js-debug-adapter',

    --- Formatter
    'dprint',
    'prettier',
    'shfmt',
    'yamlfmt',
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
            vim.notify(pkg_spec.name .. ' uninstalled successfully', vim.log.levels.INFO,
                { group = 'Mason AutoInstall' })
        end)
    )

    -- Install
    for _, server_name in ipairs(list) do
        local pkg_name, version = mp.Parse(server_name)

        if not mr.has_package(pkg_name) then
            vim.notify(pkg_name .. ' is not a valid LSP package name', vim.log.levels.ERROR,
                { group = 'Mason AutoInstall' })
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

local function init()
    local loaded = MiniDeps.get_session()
    local isLoad = vim.iter(loaded):find(function (plug)
        return plug.name == 'mason.nvim'
    end)

    if isLoad then
        vim.notify('Mason Loaded')
        return
    end

    MiniDeps.add({
        source = 'williamboman/mason.nvim',
        hooks = { post_checkout = function () vim.cmd('MasonUpdate') end },
    })

    vim.notify('Mason Loading')

    require('mason').setup({
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
    })
end


vim.keymap.set('n', '<leader>am', function ()
    init()
    vim.cmd('Mason')
end, { desc = 'Mason' })
vim.keymap.set('n', '<leader>ai', function ()
    init()
    vim.cmd('Mason')
    auto_install(enable_pkg)
end, { desc = 'Mason AutoInstall' })

-- Mason bin path
local mason_bin = vim.fn.stdpath('data') .. '/mason/bin'
---@diagnostic disable-next-line: undefined-field
local path_sep = vim.uv.os_uname().sysname == 'Windows_NT' and ';' or ':'
vim.env.PATH = mason_bin .. path_sep .. vim.env.PATH
vim.api.nvim_create_autocmd('VimLeave', {
    group = vim.api.nvim_create_augroup('MasonGroup', { clear = true }),
    callback = function ()
        vim.env.PATH = vim.env.PATH:gsub(mason_bin .. path_sep, '')
    end,
})
