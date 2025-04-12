return {
    'folke/snacks.nvim',
    priority = 1000,
    event = 'BufReadPost',
    keys = {
        { '<leader>d', function () Snacks.bufdelete() end, desc = 'Delete Buffer' },
        {
            '<leader>fd',
            function ()
                if Snacks.dim.enabled then
                    Snacks.dim.disable()
                else
                    Snacks.dim.enable()
                end
            end,
            desc = 'Toggle Dim',
        },
    },
    ---@type snacks.Config
    opts = {
        indent = {
            enabled = true,
            indent = { enabled = false },
            animate = {
                duration = {
                    step = 20,   -- ms per step
                    total = 200, -- maximum duration
                },
            },
            scope = {
                enabled = true,
                priority = 200,
                char = '⁞',
            },
        },
        scroll = {
            enabled = true,
            animate = {
                duration = {
                    step = 18,
                    total = 180,
                },
            },
        },
    },
    init = function ()
        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesActionRename',
            callback = function (event)
                Snacks.rename.on_rename_file(event.data.from, event.data.to)
            end,
        })

        -- vim.api.nvim_create_autocmd('User', {
        --     pattern = 'BufReadPost',
        --     callback = function ()
        --         Snacks.toggle.dim():map('<leader>fd')
        --     end,
        -- })
    end,
}
