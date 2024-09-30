local icons = require('util').icons
_G.stl_comp = {}

-- local palette = require('catppuccin.palettes').get_palette('latte')
local palette = require('catppuccin.palettes').get_palette('mocha')
local color_picker = {
    basebg = palette.base,
    basefg = palette.text,
    modebg = {
        n = palette.blue,   -- Normal
        i = palette.red,    -- Insert
        v = palette.green,  -- Visual
        V = palette.green,  -- Visual
        c = palette.teal,   -- Command
        R = palette.yellow, -- Replace
    },
    modefg = palette.base,
    filestatusfg = palette.yellow,
    nsearchfg = palette.sky,
    nmodefg = palette.rosewater,
    posbg = palette.surface0,
    posfg = palette.blue,
}

-- Highlight Group: start
vim.api.nvim_set_hl(0, 'StatusLineBg', { fg = color_picker.basefg, bg = color_picker.basebg })
vim.api.nvim_set_hl(0, 'StatusLineModeEdge', { fg = color_picker.modebg.n })
vim.api.nvim_set_hl(0, 'StatusLineMode', { fg = color_picker.modefg, bg = color_picker.modebg.n, bold = true })
vim.api.nvim_set_hl(0, 'StatusLineFileStatus', { fg = color_picker.filestatusfg })
-- vim.api.nvim_set_hl(0, 'StatusLineNoiceSearch', { fg = color_picker.nsearchfg })
-- vim.api.nvim_set_hl(0, 'StatusLineNoiceMode', { fg = color_picker.nmodefg })
vim.api.nvim_set_hl(0, 'StatusLinePositionEdge', { fg = color_picker.posbg })
vim.api.nvim_set_hl(0, 'StatusLinePosition', { fg = color_picker.posfg, bg = color_picker.posbg })
-- Highlight Group: end

-- Mode Color Change: start
local function set_color(color)
    vim.api.nvim_set_hl(0, 'StatusLineMode', { fg = color_picker.modefg, bg = color, bold = true })
    vim.api.nvim_set_hl(0, 'StatusLineModeEdge', { fg = color })
    vim.api.nvim_set_hl(0, 'StatusLinePosition', { fg = color, bg = color_picker.posbg })
end

local mode_change = {
    n = function ()
        set_color(color_picker.modebg.n)
    end,
    i = function ()
        set_color(color_picker.modebg.i)
    end,
    v = function ()
        set_color(color_picker.modebg.v)
    end,
    V = function ()
        set_color(color_picker.modebg.V)
    end,
    c = function ()
        set_color(color_picker.modebg.c)
    end,
    R = function ()
        set_color(color_picker.modebg.R)
    end,
}

vim.api.nvim_create_autocmd('ModeChanged', {
    callback = function (args)
        local mode = string.match(args.match, ':(.*)')
        if mode_change[mode] then
            mode_change[mode]()
        end
    end,
})
-- Mode Color Change: end

-- LSP: start
_G.stl_comp.lsp = function ()
    local count = {}
    local levels = {
        errors = vim.diagnostic.severity.ERROR,
        warnings = vim.diagnostic.severity.WARN,
        hints = vim.diagnostic.severity.HINT,
        info = vim.diagnostic.severity.INFO,
    }

    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local errors = ''
    local warnings = ''
    local hints = ''
    local info = ''

    if count['errors'] ~= 0 then
        errors = ' %#DiagnosticSignError#' .. icons.diagnostics.Error .. ' ' .. count['errors'] .. '%*'
    end
    if count['warnings'] ~= 0 then
        warnings = ' %#DiagnosticSignWarn#' .. icons.diagnostics.Warn .. ' ' .. count['warnings'] .. '%*'
    end
    if count['hints'] ~= 0 then
        hints = ' %#DiagnosticSignHint#' .. icons.diagnostics.Hint .. ' ' .. count['hints'] .. '%*'
    end
    if count['info'] ~= 0 then
        info = ' %#DiagnosticSignInfo#' .. icons.diagnostics.Info .. ' ' .. count['info'] .. '%*'
    end

    return errors .. warnings .. hints .. info
end
-- LSP: end

-- Filename and Filepath: start
_G.stl_comp.filepath = function ()
    local fpath = vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.:h')
    if fpath == '' or fpath == '.' then
        return ' '
    end
    local slash = vim.uv.os_uname().sysname == 'Windows_NT' and '\\' or '/'

    return string.format(' %%<%s' .. slash, fpath)
end

_G.stl_comp.filename = function ()
    local fname = vim.fn.expand('%:t')
    if fname == '' then
        return ''
    end
    return fname .. ' '
end
-- Filename and Filepath: end

-- Noice: start
-- local noice = require('noice').api
-- _G.stl_comp.noice_command = function ()
--     ---@diagnostic disable-next-line: undefined-field, deprecated
--     local command = noice.statusline.command.get()
--     return command == nil and '' or command
-- end
-- _G.stl_comp.noice_mode = function ()
--     ---@diagnostic disable-next-line: undefined-field, deprecated
--     local mode = noice.statusline.mode.get()
--     return mode == nil and '' or mode
-- end
-- _G.stl_comp.noice_search = function ()
--     ---@diagnostic disable-next-line: undefined-field, deprecated
--     local search = noice.statusline.search.get()
--     return search == nil and '' or search
-- end

-- Noice: end

-- Filetype: start
_G.stl_comp.filetype = function ()
    return string.format(' %s ', vim.bo.filetype):upper()
end
-- Filetype: end

vim.opt.statusline = table.concat({
    '%#StatusLineBg#',
    -- mode
    '%(',
    '%#StatusLineModeEdge#',
    ' ▌',
    '%*',
    '%#StatusLineMode#',
    ' %{v:lua.string.upper(mode())} ',
    '%*',
    '%#StatusLineModeEdge#',
    '',
    '%*',
    '%)',
    -- lsp
    ' %{%v:lua.stl_comp.lsp()%} ',
    -- -- noice search
    -- ' %(',
    -- '%#StatusLineNoiceSearch#',
    -- ' ',
    -- '%*',
    -- '%{%v:lua.stl_comp.noice_search()%}',
    -- '%) ',

    '%=',

    -- file
    '%(',
    '%{%v:lua.stl_comp.filepath()%}',
    '%{%v:lua.stl_comp.filename()%}',
    -- file status
    '%( - ',
    '%#StatusLineFileStatus#',
    '%r%m',
    '%*',
    '%) ',
    -- gitsigns
    ' %{%get(b:, "gitsigns_status", "")%} ',
    '%)',

    '%=',

    -- noice
    -- '%(',
    -- '%(',
    -- '%#StatusLineNoiceMode#',
    -- ' ',
    -- '%*',
    -- '%{%v:lua.stl_comp.noice_mode()%}',
    -- ' - ',
    -- '%)',
    -- '%{%v:lua.stl_comp.noice_command()%}',
    -- '%) ',

    -- file positions
    '%#StatusLinePositionEdge#',
    '',
    '%*',
    '%#StatusLinePosition#',
    '%(',
    '%7(%c:%l%) - %-5(%p%%%)',
    '%)',
    '%*',
    '%#StatusLinePositionEdge#',
    '',
    '%*',

    -- file data
    '%#StatusLineModeEdge#',
    '',
    '%*',
    '%#StatusLineMode#',
    '%(',
    ' %Y / %{toupper(&fileencoding)} / %{toupper(&fileformat)} ',
    '%)',
    '%*',
    '%#StatusLineModeEdge#',
    '▐ ',
    '%*',
})

return {
    dir = vim.fn.stdpath('config') .. '/lua/plugins_full/statusline',
    event = 'BufReadPost',
    -- dependencies = { 'folke/noice.nvim' },
}
