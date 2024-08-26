local M = {}

M.icons = {
    dap = {
        Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
        Breakpoint = { ' ' },
        BreakpointCondition = { ' ' },
        BreakpointRejected = { ' ', 'DiagnosticError' },
        LogPoint = { '.>' },
    },
    diagnostics = {
        Sign = '',
        Error = '🅴',
        Warn = '🆆',
        Hint = '🅷',
        Info = '🅸',
    },
    git = {
        added = '',
        changed = '',
        removed = '',
    },
    file_status = {
        modified = '[+]',
        readonly = '[R]',
        unnamed = '[~]',
        newfile = '[N]',
    },
}

---Get Mason Packages Command Path from packages
---@param pkg string name without path slash
---@param path? string start from slash (and end of slash)
---@param target? string command name
---@return string - command path
function M.get_pkg_path(pkg, path, target)
    local root = vim.fn.stdpath('data') .. '/mason/packages/'
    path = path or ''
    target = target or ''
    return root .. pkg .. path .. target
end

---Get Mason Packages Command Path from bin
---@param target string command name
---@return string - command path
function M.get_cmd_path(target)
    local root = vim.fn.stdpath('data') .. '/mason/bin/'
    return root .. target
end

return M
