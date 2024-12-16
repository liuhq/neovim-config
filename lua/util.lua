local M = {}

M.icons = {
    dap = {
        Stopped = '󰁕 ',
        Breakpoint = ' ',
        BreakpointCondition = ' ',
        LogPoint = ' ',
    },
    diagnostics = {
        Sign = '▪',
        Error = '',
        Warn = '',
        Info = '',
        Hint = '',
    },
    git = {
        added = '󰐕',
        changed = '󰧞',
        removed = '󰍴',
    },
    file_status = {
        modified = '󰏪',
        readonly = '󰌾',
        unnamed = '󰜥',
        newfile = '󰈔',
    },
}

---Get Mason Packages Command Path from bin
---@param target string command name
---@return string - command path
function M.get_cmd_path(target)
    local root = vim.fn.stdpath('data') .. '/mason/bin/'
    return root .. target
end

---Get files name in target directory
---@param target string target directory path
---@return table files name
function M.get_files_in_dir(target)
    local files = {}

    ---@diagnostic disable-next-line: undefined-field
    if (not vim.uv.fs_stat(target)) or vim.uv.fs_stat(target).type ~= 'directory' then
        print('Invalid directory: ' .. target)
        return files
    end

    for name, type in vim.fs.dir(target) do
        if type == 'file' then
            table.insert(files, (name:gsub('%.lua$', '')))
        end
    end

    return files
end

return M
