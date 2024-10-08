local vscode = require('vscode')

local keymap_help_a = function ()
    vim.cmd([[
redir => output
echomsg "<C-S-U>       (Close Output Panel)"
echomsg "Keymap Help"
echomsg ""
echomsg "  <>ab        (Buffers)"
echomsg "  <>ag        (Goto)"
echomsg "  <>al        (LSP)"
echomsg "  <>an        (Notifications)"
echomsg "  <>ao        (Others)"
echomsg "  <>aw        (Windows)"
redir END
echo output
    ]])
    vscode.call('workbench.panel.output.focus')
end

local keymap_help_b = function ()
    vim.cmd([[
redir => output
echomsg "<C-S-U>       (Close Output Panel)"
echomsg "Buffers"
echomsg ""
echomsg "  <S-H>       (Prev Buffer)"
echomsg "  <S-L>       (Next Buffer)"
echomsg "  <>d         (Delete Buffer)"
echomsg "  <>bt        (Switch to Other Buffer)"
echomsg "  <>bp        (Pin Buffer)"
echomsg "  <>bu        (Unpin Buffer)"
redir END
echo output
    ]])
    vscode.call('workbench.panel.output.focus')
end

local keymap_help_g = function ()
    vim.cmd([[
redir => output
echomsg "<C-S-U>       (Close Output Panel)"
echomsg "Goto"
echomsg ""
echomsg "  gh          (Show Hover)"
echomsg "  gs          (Signature Help)"
echomsg "  gd          (Definition)"
echomsg "  gD          (Declaration)"
echomsg "  gi          (Implementation)"
echomsg "  gr          (References)"
echomsg "  gt          (Type Definition)"
echomsg "  [x          (Prev Diagnostic)"
echomsg "  ]x          (Next Diagnostic)"
echomsg ""
echomsg "  gcb         (Block Comment)"
echomsg "  gb          (Block Comment in Visual Mode)"
redir END
echo output
    ]])
    vscode.call('workbench.panel.output.focus')
end

local keymap_help_l = function ()
    vim.cmd([[
redir => output
echomsg "<C-S-U>       (Close Output Panel)"
echomsg "LSP"
echomsg ""
echomsg "  <>ca        (Code Action)"
echomsg "  <>cr        (Rename)"
echomsg "  <>ct        (Refactor)"
echomsg "  <>cs        (Source Action)"
echomsg "  <>cf        (Format)"
echomsg "  <>cf        (Format in Visual Mode)"
echomsg "  <>pd        (Peek Definition)"
echomsg "  <>pD        (Peek Declaration)"
echomsg "  <>pi        (Peek Implementation)"
echomsg "  <>pr        (Peek References)"
echomsg "  <>pt        (Peek Type Definition)"
redir END
echo output
    ]])
    vscode.call('workbench.panel.output.focus')
end

local keymap_help_n = function ()
    vim.cmd([[
redir => output
echomsg "<C-S-U>       (Close Output Panel)"
echomsg "Notifications"
echomsg ""
echomsg "  <>nh        (Notifications)"
echomsg "  <>nd        (Dismiss Notifications)"
echomsg "  <>nc        (Clear Notifications)"
redir END
echo output
    ]])
    vscode.call('workbench.panel.output.focus')
end

local keymap_help_o = function ()
    vim.cmd([[
redir => output
echomsg "<C-S-U>       (Close Output Panel)"
echomsg "Others"
echomsg ""
echomsg "  <><>        (Files)"
echomsg "  <>s         (Explorer)"
echomsg "  <>z         (Zen Mode)"
echomsg "  za          (Toggle Fold)"
echomsg "  zA          (Toggle Fold Recursively)"
redir END
echo output
    ]])
    vscode.call('workbench.panel.output.focus')
end

local keymap_help_w = function ()
    vim.cmd([[
redir => output
echomsg "<C-S-U>       (Close Output Panel)"
echomsg "Windows"
echomsg ""
echomsg "  <>wd        (Delete Window)"
echomsg "  <>ws        (Split Window Below)"
echomsg "  <>wv        (Split Window Right)"
redir END
echo output
    ]])
    vscode.call('workbench.panel.output.focus')
end

return {
    dir = vim.fn.stdpath('config') .. '/lua/plugins_vscode/local-keymap-help',
    keys = {
        { '<leader>aa', keymap_help_a },
        { '<leader>ab', keymap_help_b },
        { '<leader>ag', keymap_help_g },
        { '<leader>al', keymap_help_l },
        { '<leader>an', keymap_help_n },
        { '<leader>ao', keymap_help_o },
        { '<leader>aw', keymap_help_w },
    }
}
