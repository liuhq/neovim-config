local M = {}

M.pkg_name = 'js-debug-adapter'

function M.setup()
    local dap = require('dap')
    local adapter = require('util').get_pkg_path('js-debug-adapter', '/js-debug/src/', 'dapDebugServer.js')

    dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
            command = 'node',
            args = { adapter, '${port}' },
        },
    }

    dap.adapters['node'] = function (cb, config)
        if config.type == 'node' then
            config.type = 'pwa-node'
        end
        local nativeAdapter = dap.adapters['pwa-node']
        if type(nativeAdapter) == 'function' then
            nativeAdapter(cb, config)
        else
            cb(nativeAdapter)
        end
    end

    local js_filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }
    local vscode = require('dap.ext.vscode')
    vscode.type_to_filetypes['node'] = js_filetypes
    vscode.type_to_filetypes['pwa-node'] = js_filetypes

    for _, lang in ipairs(js_filetypes) do
        if not dap.configurations[lang] then
            dap.configurations[lang] = {
                {
                    type = 'pwa-node',
                    request = 'launch',
                    name = 'Launch file',
                    program = '${file}',
                    cwd = '${workspaceFolder}',
                },
                {
                    type = 'pwa-node',
                    request = 'attach',
                    name = 'Attach',
                    processId = require('dap.utils').pick_process,
                    cwd = '${workspaceFolder}',
                },
            }
        end
    end
end

return M
