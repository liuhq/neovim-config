local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('@variable.member.private.javascript', '', '', { italic = true })
    hl('@variable.member.private.typescript', '', '', { italic = true })
    hl('@variable.member.private.tsx', { link = '@variable.member.private.typescript' })

    hl('@markup.link.label.javascript', C.aurora_green, '', { underline = false })
    hl('@markup.link.label.tsx', C.aurora_green, '', { underline = false })
end

return M
