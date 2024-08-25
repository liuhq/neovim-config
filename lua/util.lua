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

---Get Mason Packages Path
---@param pkg string name without path slash
---@param path? string start from slash (or end of slash)
---@param target? string program name
function M.get_pkg_path(pkg, path, target)
    local root = vim.fn.stdpath('data') .. '/mason/packages/'
    path = path or ''
    target = target or ''
    return root .. pkg .. path .. target
end

return M
