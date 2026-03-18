return function ()
    MiniDeps.add({ source = 'mrcjkb/rustaceanvim' })

    ---@type rustaceanvim.Opts
    vim.g.rustaceanvim = {
        tools = {
            code_actions = {
                ui_select_fallback = true,
            },
        },
    }
end
