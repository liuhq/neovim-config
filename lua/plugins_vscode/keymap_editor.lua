local keymap = vim.keymap
local vscode = require('vscode')

-- files
keymap.set('n', '<leader><leader>', function() vscode.call('workbench.action.quickOpen') end, { desc = 'Files' })

-- coding
keymap.set({ 'n', 'v' }, 'gC', function() vscode.call('editor.action.blockComment') end, { desc = 'Block Comment' })

-- buffers
keymap.set('n', '<S-h>', function() vscode.call('workbench.action.previousEditorInGroup') end, { desc = 'Prev Buffer' })
keymap.set('n', '<S-l>', function() vscode.call('workbench.action.nextEditorInGroup') end, { desc = 'Next Buffer' })
keymap.set('n', '<leader>bt', function() vscode.call('workbench.action.openPreviousRecentlyUsedEditorInGroup') end, { desc = 'Switch to Other Buffer' })
keymap.set('n', '<leader>bd', function() vscode.call('workbench.action.closeActiveEditor') end, { desc = 'Delete Buffer' })
keymap.set('n', '<leader>bp', function() vscode.call('workbench.action.pinEditor') end, { desc = 'Pin Buffer' })
keymap.set('n', '<leader>bP', function() vscode.call('workbench.action.unpinEditor') end, { desc = 'Pin Buffer' })

-- windows
keymap.set('n', '<leader>wd', function() vscode.call('workbench.action.closeGroup') end, { desc = 'Delete Window' })
keymap.set('n', '<leader>ws', function() vscode.call('workbench.action.splitEditorDown') end, { desc = 'Split Window Below' })
keymap.set('n', '<leader>wv', function() vscode.call('workbench.action.splitEditorRight') end, { desc = 'Split Window Right' })

-- move to window using the <ctrl> hjkl keys
keymap.set('n', '<C-k>', function() vscode.call('workbench.action.focusAboveGroup') end, { desc = 'Go to Above Window' })
keymap.set('n', '<C-j>', function() vscode.call('workbench.action.focusBelowGroup') end, { desc = 'Go to Below Window' })
keymap.set('n', '<C-h>', function() vscode.call('workbench.action.focusLeftGroup') end, { desc = 'Go to Left Window' })
keymap.set('n', '<C-l>', function() vscode.call('workbench.action.focusRightGroup') end, { desc = 'Go to Right Window' })

-- resize window using <ctrl> arrow keys
keymap.set('n', '<C-Up>', function() vscode.call('workbench.action.increaseViewHeight') end, { desc = 'Increase Window Height' })
keymap.set('n', '<C-Down>', function() vscode.call('workbench.action.decreaseViewHeight') end, { desc = 'Decrease Window Height' })
keymap.set('n', '<C-Right>', function() vscode.call('workbench.action.increaseViewWidth') end, { desc = 'Increase Window Width' })
keymap.set('n', '<C-Left>', function() vscode.call('workbench.action.decreaseViewWidth') end, { desc = 'Decrease Window Width' })

-- notifications
keymap.set('n', '<leader>nh', function() vscode.call('notifications.showList') end, { desc = 'Notifications' })
keymap.set('n', '<leader>nd', function() vscode.call('notifications.hideList') end, { desc = 'Dismiss Notifications' })
keymap.set('n', '<leader>nc', function() vscode.call('notifications.clearAll') end, { desc = 'Clear Notifications' })

-- Zen mode
keymap.set('n', '<leader>az', function() vscode.call('workbench.action.toggleZenMode') end, { desc = 'Zen Mode'})

-- keymap.set('n', '<leader>"', function()
--     local r = ''
--     local m = { '*', '+', '"', '-', '%', '/' }
--     for i = 0, 9 do
--         table.insert(m, i)
--     end
--     for i = 97, 122 do
--         local letter = string.char(i)
--         if vim.fn.getreg(letter) ~= '' then
--             table.insert(m, letter)
--         end
--     end
--     vscode.notify(vim.fn.getreg('*') .. 'newline')
-- end, { desc = 'Zen Mode'})

return {
    dir = vim.fn.stdpath('config') .. '/lua/plugins_vscode/keymap_editor',
    event = 'VeryLazy'
}
