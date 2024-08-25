local icons = require('util').icons

---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
    local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {}
    config = vim.deepcopy(config)
    ---@cast args string[]
    config.args = function ()
        local new_args = vim.fn.input('Run with args: ', table.concat(args, ' ')) --[[@as string]]
        return vim.split(vim.fn.expand(new_args) --[[@as string]], ' ')
    end
    return config
end

---Enable Dap config
---@param dap_pkg {pkg_name: string, setup: fun()}
local function config_dap(dap_pkg)
    local dap_set = require('plugins_native.dap.set')
    if not dap_set.enable_pkg[dap_pkg.pkg_name] then
        return
    else
        dap_pkg.setup()
    end
end

return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'nvim-dap-ui',
            'nvim-dap-virtual-text',
        },
        keys = {
            { '<F5>', function () require('dap').continue() end, desc = 'Continue' },
            { '<F10>', function () require('dap').step_over() end, desc = 'Step Over' },
            { '<F11>', function () require('dap').step_into() end, desc = 'Step Into' },
            { '<F12>', function () require('dap').step_out() end, desc = 'Step Out' },
            { '<leader>da', function () require('dap').continue({ before = get_args }) end, desc = 'Run with Args' },
            { '<leader>dr', function () require('dap').restart() end, desc = 'Restart Session' },
            { '<leader>dp', function () require('dap').pause() end, desc = 'Pause' },
            { '<leader>dt', function () require('dap').terminate() end, desc = 'Terminate' },
            { '<leader>db', function () require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
            { '<leader>dB', function () require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Breakpoint Condition' },
            { '<leader>dl', function () require('dap').list_breakpoints() end, desc = 'List Breakpoint' },
            { '<leader>dC', function () require('dap').clear_breakpoints() end, desc = 'Clear Breakpoint' },
            { '<leader>dc', function () require('dap').run_to_cursor() end, desc = 'Run to Cursor' },
            { '<leader>dg', function () require('dap').goto_() end, desc = 'Go to Line (No Execute)' },
            { '<leader>dj', function () require('dap').down() end, desc = 'Stacktrace Down' },
            { '<leader>dk', function () require('dap').up() end, desc = 'Stacktrace Up' },
            { '<leader>dL', function () require('dap').run_last() end, desc = 'Run Last' },
            { '<leader>dR', function () require('dap').repl.toggle() end, desc = 'Toggle REPL' },
            { '<leader>dh', function () require('dap.ui.widgets').hover() end, desc = 'Widgets' },
        },
        config = function ()
            config_dap(require('plugins_native.dap.config.js-debug-adapter'))

            vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

            for name, sign in pairs(icons.dap) do
                vim.fn.sign_define(
                    'Dap' .. name,
                    { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] }
                )
            end

            -- setup dap config by VsCode launch.json file
            local vscode = require('dap.ext.vscode')
            local json = require('plenary.json')
            ---@diagnostic disable-next-line: duplicate-set-field
            vscode.json_decode = function (str)
                ---@diagnostic disable-next-line: missing-parameter
                return vim.json.decode(json.json_strip_comments(str))
            end

            -- Extends dap.configurations with entries read from .vscode/launch.json
            if vim.fn.filereadable('.vscode/launch.json') then
                vscode.load_launchjs()
            end
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'nvim-neotest/nvim-nio' },
        keys = {
            { '<leader>dd', function () require('dapui').toggle({}) end, desc = 'Dap UI' },
            { '<leader>de', function () require('dapui').eval() end, desc = 'Eval', mode = { 'n', 'v' } },
        },
        config = function ()
            local dap = require('dap')
            local dapui = require('dapui')

            dapui.setup()

            dap.listeners.after.event_initialized['dapui_config'] = function ()
                dapui.open({})
            end
            dap.listeners.before.event_terminated['dapui_config'] = function ()
                dapui.close({})
            end
            dap.listeners.before.event_exited['dapui_config'] = function ()
                dapui.close({})
            end
        end,
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        lazy = true,
        config = function ()
            require('nvim-dap-virtual-text').setup()
        end,
    },
}
