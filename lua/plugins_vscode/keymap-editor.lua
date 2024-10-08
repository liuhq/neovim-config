local keymap = vim.keymap
local vscode = require('vscode')

--[[
    multi-cursors:
        1. <C-V> or V to selection area
        2. mi or ma to insert cursors
--]]

-- files
keymap.set('n', '<leader><leader>', function () vscode.call('workbench.action.quickOpen') end, { desc = 'Files' })
keymap.set('n', '<leader>s', function () vscode.call('workbench.action.toggleSidebarVisibility') end, { desc = 'Explorer' })

-- coding
keymap.set('n', 'gcb', function () vscode.call('editor.action.blockComment') end, { desc = 'Block Comment' })
keymap.set('v', 'gb', function () vscode.call('editor.action.blockComment') end, { desc = 'Block Comment' })

-- fold
keymap.set('n', 'za', function () vscode.call('editor.toggleFold') end, { desc = 'Toggle Fold' })
keymap.set('n', 'zA', function () vscode.call('editor.toggleFoldRecursively') end, { desc = 'Toggle Fold Recursively' })

-- buffers
keymap.set('n', '<S-h>', function () vscode.call('workbench.action.previousEditorInGroup') end, { desc = 'Prev Buffer' })
keymap.set('n', '<S-l>', function () vscode.call('workbench.action.nextEditorInGroup') end, { desc = 'Next Buffer' })
keymap.set('n', '<leader>bt', function () vscode.call('workbench.action.openPreviousRecentlyUsedEditorInGroup') end, { desc = 'Switch to Other Buffer' })
keymap.set('n', '<leader>d', function () vscode.call('workbench.action.closeActiveEditor') end, { desc = 'Delete Buffer' })
keymap.set('n', '<leader>bp', function () vscode.call('workbench.action.pinEditor') end, { desc = 'Pin Buffer' })
keymap.set('n', '<leader>bu', function () vscode.call('workbench.action.unpinEditor') end, { desc = 'Unpin Buffer' })

-- windows
keymap.set('n', '<leader>wd', function () vscode.call('workbench.action.closeGroup') end, { desc = 'Delete Window' })
keymap.set('n', '<leader>ws', function () vscode.call('workbench.action.splitEditorDown') end, { desc = 'Split Window Below' })
keymap.set('n', '<leader>wv', function () vscode.call('workbench.action.splitEditorRight') end, { desc = 'Split Window Right' })

-- move to window using the <ctrl> hjkl keys
keymap.set('n', '<C-k>', function () vscode.call('workbench.action.focusAboveGroup') end, { desc = 'Go to Above Window' })
keymap.set('n', '<C-j>', function () vscode.call('workbench.action.focusBelowGroup') end, { desc = 'Go to Below Window' })
keymap.set('n', '<C-h>', function () vscode.call('workbench.action.focusLeftGroup') end, { desc = 'Go to Left Window' })
keymap.set('n', '<C-l>', function () vscode.call('workbench.action.focusRightGroup') end, { desc = 'Go to Right Window' })

-- resize window using <ctrl> arrow keys
keymap.set('n', '<C-Up>', function () vscode.call('workbench.action.increaseViewHeight') end, { desc = 'Increase Window Height' })
keymap.set('n', '<C-Down>', function () vscode.call('workbench.action.decreaseViewHeight') end, { desc = 'Decrease Window Height' })
keymap.set('n', '<C-Right>', function () vscode.call('workbench.action.increaseViewWidth') end, { desc = 'Increase Window Width' })
keymap.set('n', '<C-Left>', function () vscode.call('workbench.action.decreaseViewWidth') end, { desc = 'Decrease Window Width' })

-- notifications
keymap.set('n', '<leader>nh', function () vscode.call('notifications.showList') end, { desc = 'Notifications' })
keymap.set('n', '<leader>nd', function () vscode.call('notifications.hideToasts') end, { desc = 'Dismiss Notifications' })
keymap.set('n', '<leader>nc', function () vscode.call('notifications.clearAll') end, { desc = 'Clear Notifications' })

-- Zen mode
keymap.set('n', '<leader>z', function () vscode.call('workbench.action.toggleZenMode') end, { desc = 'Zen Mode' })

return {
    dir = vim.fn.stdpath('config') .. '/lua/plugins_vscode/keymap-editor',
    event = 'VeryLazy',
}
