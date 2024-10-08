if vim.g.vscode then
    return
end

local bo = vim.bo

bo.matchpairs = bo.matchpairs .. ',<:>'
bo.shiftwidth = 2
bo.tabstop = 2
bo.softtabstop = 2
