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

---Get Mason Packages Command Path from bin
---@param target string command name
---@return string - command path
function M.get_cmd_path(target)
    local root = vim.fn.stdpath('data') .. '/mason/bin/'
    return root .. target
end

return M
