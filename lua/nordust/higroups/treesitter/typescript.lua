local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('@variable.member.private.typescript', '', '', { italic = true })
    hl('@variable.member.private.typescriptreact', { link = '@variable.member.private.typescript' })
end

return M
