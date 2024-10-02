local icons = require('util').icons
_G.stl_comp = {}

local palette = require('catppuccin.palettes').get_palette('mocha')
local cp = {
    basebg = palette.crust,
    basefg = palette.text,
    modebg = {
        ['n'] = palette.lavender,
        ['no'] = palette.lavender,
        ['i'] = palette.green,
        ['ic'] = palette.green,
        ['t'] = palette.green,
        ['v'] = palette.flamingo,
        ['V'] = palette.flamingo,
        [''] = palette.flamingo,
        ['R'] = palette.maroon,
        ['Rv'] = palette.maroon,
        ['s'] = palette.maroon,
        ['S'] = palette.maroon,
        [''] = palette.maroon,
        ['c'] = palette.peach,
        ['cv'] = palette.peach,
        ['ce'] = palette.peach,
        ['r'] = palette.teal,
        ['rm'] = palette.teal,
        ['r?'] = palette.mauve,
        ['!'] = palette.green,
    },
    modefg = palette.crust,
    lspfg = {
        error = palette.red,
        warning = palette.yellow,
        info = palette.sky,
        hint = palette.teal,
    },
    lspbg = palette.crust,
    filestatusfg = palette.yellow,
    posbg = palette.surface0,
    posfg = palette.blue,
}
vim.api.nvim_set_hl(0, 'StatusLineBg', { fg = cp.basefg, bg = cp.basebg })
vim.api.nvim_set_hl(0, 'StatusLineMode', { fg = cp.modefg, bg = cp.modebg['n'] })
vim.api.nvim_set_hl(0, 'StatusLineFileStatus', { fg = cp.filestatusfg })
vim.api.nvim_set_hl(0, 'StatusLinePosition', { fg = cp.posfg, bg = cp.posbg })


vim.api.nvim_create_autocmd('OptionSet', {
    group = vim.api.nvim_create_augroup('StatuslineBg', { clear = true }),
    pattern = 'background',
    callback = function ()
        if vim.o.background == 'light' then
            palette = require('catppuccin.palettes').get_palette('latte')
        else
            palette = require('catppuccin.palettes').get_palette('mocha')
        end
        cp = {
            basebg = palette.crust,
            basefg = palette.text,
            modebg = {
                ['n'] = palette.lavender,
                ['no'] = palette.lavender,
                ['i'] = palette.green,
                ['ic'] = palette.green,
                ['t'] = palette.green,
                ['v'] = palette.flamingo,
                ['V'] = palette.flamingo,
                [''] = palette.flamingo,
                ['R'] = palette.maroon,
                ['Rv'] = palette.maroon,
                ['s'] = palette.maroon,
                ['S'] = palette.maroon,
                [''] = palette.maroon,
                ['c'] = palette.peach,
                ['cv'] = palette.peach,
                ['ce'] = palette.peach,
                ['r'] = palette.teal,
                ['rm'] = palette.teal,
                ['r?'] = palette.mauve,
                ['!'] = palette.green,
            },
            modefg = palette.crust,
            lspfg = {
                error = palette.red,
                warning = palette.yellow,
                info = palette.sky,
                hint = palette.teal,
            },
            lspbg = palette.crust,
            filestatusfg = palette.yellow,
            posbg = palette.surface0,
            posfg = palette.blue,
        }
        vim.api.nvim_set_hl(0, 'StatusLineBg', { fg = cp.basefg, bg = cp.basebg })
        vim.api.nvim_set_hl(0, 'StatusLineMode', { fg = cp.modefg, bg = cp.modebg['n'] })
        vim.api.nvim_set_hl(0, 'StatusLineFileStatus', { fg = cp.filestatusfg })
        vim.api.nvim_set_hl(0, 'StatusLinePosition', { fg = cp.posfg, bg = cp.posbg })
    end,
})


-- Mode Color Change: start
local function mode_change(mode)
    vim.api.nvim_set_hl(0, 'StatusLineMode', { fg = cp.modefg, bg = cp.modebg[mode], bold = true })
    vim.api.nvim_set_hl(0, 'StatusLinePosition', { fg = cp.modebg[mode], bg = cp.posbg })
end

vim.api.nvim_create_autocmd('ModeChanged', {
    callback = function (args)
        local mode = string.match(args.match, ':(.*)')
        if cp.modebg[mode] then
            mode_change(mode)
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
        vim.api.nvim_set_hl(0, 'StatusLineLspError', { fg = cp.lspfg.error, bg = cp.lspbg })
        errors = ' %#StatusLineLspError#' .. icons.diagnostics.Error .. ' ' .. count['errors'] .. '%*'
    end
    if count['warnings'] ~= 0 then
        vim.api.nvim_set_hl(0, 'StatusLineLspWarn', { fg = cp.lspfg.warning, bg = cp.lspbg })
        warnings = ' %#StatusLineLspWarn#' .. icons.diagnostics.Warn .. ' ' .. count['warnings'] .. '%*'
    end
    if count['info'] ~= 0 then
        vim.api.nvim_set_hl(0, 'StatusLineLspInfo', { fg = cp.lspfg.info, bg = cp.lspbg })
        info = ' %#StatusLineLspInfo#' .. icons.diagnostics.Info .. ' ' .. count['info'] .. '%*'
    end
    if count['hints'] ~= 0 then
        vim.api.nvim_set_hl(0, 'StatusLineLspHint', { fg = cp.lspfg.hint, bg = cp.lspbg })
        hints = ' %#StatusLineLspHint#' .. icons.diagnostics.Hint .. ' ' .. count['hints'] .. '%*'
    end

    return errors .. warnings .. info .. hints
end
-- LSP: end


-- Filename and Filepath: start
_G.stl_comp.filepath = function ()
    local fpath = vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.:h')
    if fpath == '' or fpath == '.' then
        return ' '
    end
    ---@diagnostic disable-next-line: undefined-field
    local slash = vim.uv.os_uname().sysname == 'Windows_NT' and '\\' or '/'

    return string.format(' %%<%s' .. slash, fpath)
end

_G.stl_comp.filename = function ()
    local fname = vim.fn.expand('%:t')
    if fname == '' then
        return ''
    end
    return fname
end
-- Filename and Filepath: end


-- Filestatus: start
_G.stl_comp.file_readonly = function ()
    return vim.bo.readonly and icons.file_status.readonly or ''
end

_G.stl_comp.file_modified = function ()
    return vim.bo.modified and icons.file_status.modified or ''
end
-- Filestatus: end


-- Filetype: start
_G.stl_comp.filetype = function ()
    return string.format(' %s ', vim.bo.filetype):upper()
end
-- Filetype: end


vim.opt.statusline = table.concat({
    '%#StatusLineBg#',

    -- mode
    '%(',
    '%#StatusLineMode#',
    ' ▌',
    ' %{v:lua.string.upper(mode(1))} ▐',
    '%*',
    '%)',
    -- lsp
    ' %{%v:lua.stl_comp.lsp()%} ',

    ----------------------------------------
    '%=',
    ----------------------------------------

    -- file
    '%(',
    '%{%v:lua.stl_comp.filepath()%}',
    '%{%v:lua.stl_comp.filename()%}',
    -- file status
    '%( : ',
    '%#StatusLineFileStatus#',
    '%{%v:lua.stl_comp.file_readonly()%}',
    '%{%v:lua.stl_comp.file_modified()%}',
    '%*',
    '%) ',
    -- gitsigns
    ' %{%get(b:, "gitsigns_status", "")%}',
    '%)',

    ----------------------------------------
    '%=',
    ----------------------------------------

    -- file positions
    '%#StatusLinePosition#',
    '%(',
    ' %7(%c:%l%) - %-5(%p%%%) ',
    '%)',
    '%*',

    -- file data
    '%(',
    '%#StatusLineMode#',
    '▌ %Y / %{toupper(&fileencoding)} / %{toupper(&fileformat)} ',
    '▐ ',
    '%)',
})

return {
    dir = vim.fn.stdpath('config') .. '/lua/plugins/local-statusline',
    event = 'BufReadPost',
}
