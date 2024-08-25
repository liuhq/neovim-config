local keymap = vim.keymap
local vscode = require('vscode')

-- hover
keymap.set('n', '<S-k>', function() vscode.call('editor.action.showHover') end, { desc = 'Show Hover' })

-- code
keymap.set('n', '<leader>ca', function() vscode.call('editor.action.quickFix') end, { desc = 'Code Action' })
keymap.set('n', '<leader>cn', function() vscode.call('editor.action.rename') end, { desc = 'Rename' })
keymap.set('n', '<leader>cr', function() vscode.call('editor.action.refactor') end, { desc = 'Refactor' })
keymap.set('n', '<leader>cA', function() vscode.call('editor.action.sourceAction') end, { desc = 'Source Action' })
keymap.set('n', '<leader>cf', function() vscode.call('editor.action.formatDocument') end, { desc = 'Format' })
keymap.set('v', '<leader>cf', function() vscode.call('editor.action.formatSelection') end, { desc = 'Format Selection' })

-- lsp jump
keymap.set('n', 'gd', function() vscode.call('editor.action.revealDefinition') end, { desc = 'Definition' })
keymap.set('n', 'gt', function() vscode.call('editor.action.goToTypeDefinition') end, { desc = 'Type Definition' })
keymap.set('n', 'gi', function() vscode.call('editor.action.goToImplementation') end, { desc = 'Implementation' })
keymap.set('n', 'gr', function() vscode.call('editor.action.goToReferences') end, { desc = 'References' })
keymap.set('n', 'gD', function() vscode.call('editor.action.revealDeclaration') end, { desc = 'Declaration' })

-- lsp peek
keymap.set('n', '<leader>pd', function() vscode.call('editor.action.peekDefinition') end, { desc = 'Peek Definition' })
keymap.set('n', '<leader>pt', function() vscode.call('editor.action.peekTypeDefinition') end, { desc = 'Peek Type Definition' })
keymap.set('n', '<leader>pt', function() vscode.call('editor.action.peekImplementation') end, { desc = 'Peek Implementation' })
keymap.set('n', '<leader>pr', function() vscode.call('editor.action.referenceSearch.trigger') end, { desc = 'Peek References' })
keymap.set('n', '<leader>pD', function() vscode.call('editor.action.peekDeclaration') end, { desc = 'Peek Declaration' })

return {
    dir = vim.fn.stdpath('config') .. '/lua/plugins_vscode/keymap_lsp',
    event = 'VeryLazy'
}
