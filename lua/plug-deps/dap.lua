return function ()
    MiniDeps.add({ source = 'mfussenegger/nvim-dap' })

    local icons = ConfigUtil.icons

    local dap = require('dap')
    local api = vim.api

    ------------------------------------------
    --- C & Rust via codelldb & gdb
    ------------------------------------------
    dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
            command = vim.fn.exepath('codelldb'),
            args = { '--port', '${port}' },
            -- On windows you may have to uncomment this:
            detached = false,
        },
    }
    dap.adapters.gdb = {
        type = 'executable',
        command = 'gdb',
        args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
    }

    dap.configurations.c = {
        {
            name = '[codelldb] Launch',
            type = 'codelldb',
            request = 'launch',
            program = function ()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
        },
        {
            name = '[gdb] Launch',
            type = 'gdb',
            request = 'launch',
            program = function ()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopAtBeginningOfMainSubprogram = false,
        },
        {
            name = '[gdb] Select and attach to process',
            type = 'gdb',
            request = 'attach',
            program = function ()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            pid = function ()
                local name = vim.fn.input('Executable name (filter): ')
                return require('dap.utils').pick_process({ filter = name })
            end,
            cwd = '${workspaceFolder}',
        },
        {
            name = '[gdb] Attach to gdbserver :1234',
            type = 'gdb',
            request = 'attach',
            target = 'localhost:1234',
            program = function ()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
        },
    }
    dap.configurations.rust = dap.configurations.c

    ------------------------------------------
    --- JS
    ------------------------------------------
    dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
            command = 'node',
            args = { vim.fn.exepath('js-debug-adapter'), '${port}' },
        },
    }
    dap.configurations.javascript = {
        {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
        },
    }


    --- map K to hover while session is active
    local keymap_restore = {}
    dap.listeners.after['event_initialized']['me'] = function ()
        for _, buf in pairs(api.nvim_list_bufs()) do
            local keymaps = api.nvim_buf_get_keymap(buf, 'n')
            for _, keymap in pairs(keymaps) do
                ---@diagnostic disable-next-line: undefined-field
                if keymap.lhs == 'K' then
                    table.insert(keymap_restore, keymap)
                    api.nvim_buf_del_keymap(buf, 'n', 'K')
                end
            end
        end
        api.nvim_set_keymap('n', 'K', '<cmd>lua require("dap.ui.widgets").hover()<cr>', { silent = true })
    end

    dap.listeners.after['event_terminated']['me'] = function ()
        for _, keymap in pairs(keymap_restore) do
            api.nvim_buf_set_keymap(
                keymap.buffer,
                keymap.mode,
                keymap.lhs,
                keymap.rhs,
                { silent = keymap.silent == 1 }
            )
        end
        keymap_restore = {}
    end

    --- sign style
    local sign = vim.fn.sign_define
    sign('DapBreakpoint', { text = icons.dap.Breakpoint, texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    sign('DapBreakpointCondition',
        { text = icons.dap.BreakpointCondition, texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
    sign('DapLogPoint', { text = icons.dap.LogPoint, texthl = 'DapLogPoint', linehl = '', numhl = '' })

    vim.keymap.set('n', '<leader>vb', function () require('dap').toggle_breakpoint() end, { desc = 'Breakpoint' })
    vim.keymap.set('n', '<leader>vl', function () require('dap').list_breakpoints() end, { desc = 'List Breakpoints' })
    vim.keymap.set('n', '<leader>vc', function () require('dap').clear_breakpoints() end, { desc = 'Clear Breakpoints' })
    vim.keymap.set('n', '<leader>vv', function () require('dap').continue() end, { desc = 'Launch / Continue' })
    vim.keymap.set('n', '<leader>vp', function () require('dap').pause() end, { desc = 'Pause' })
    vim.keymap.set('n', '<leader>v,', function () require('dap').restart() end, { desc = 'Restart' })
    vim.keymap.set('n', '<leader>vt', function () require('dap').terminate() end, { desc = 'Terminate' })
    vim.keymap.set('n', '<leader>va', function () require('dap').step_over() end, { desc = 'Step Over' })
    vim.keymap.set('n', '<leader>vs', function () require('dap').step_into() end, { desc = 'Step Into' })
    vim.keymap.set('n', '<leader>vd', function () require('dap').step_out() end, { desc = 'Step Out' })
    vim.keymap.set('n', '<leader>vg', function () require('dap').run_to_cursor() end, { desc = 'Run to Cursor' })
    vim.keymap.set('n', '<leader>vr', function () require('dap').repl.toggle() end, { desc = 'REPL' })
    vim.keymap.set('n', '<leader>vw', function () require('dap.ui.widgets').preview() end, { desc = 'DAP Widget' })
end
