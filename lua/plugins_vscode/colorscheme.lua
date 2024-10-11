local hex_to_rgb = function(hex_str)
	local hex = "[abcdef0-9][abcdef0-9]"
	local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
	hex_str = string.lower(hex_str)

	assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

	local red, green, blue = string.match(hex_str, pat)
	return { tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16) }
end

local blend = function(fg, bg, alpha)
	bg = hex_to_rgb(bg)
	fg = hex_to_rgb(fg)

	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

local darken = function(hex, amount, bg)
    return blend(hex, bg, math.abs(amount))
end

return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false,
        priority = 1000,
        ---@type CatppuccinOptions
        opts = {
            flavour = 'mocha', -- latte, frappe, macchiato, mocha
            background = {     -- :h background
                light = 'latte',
                dark = 'mocha',
            },
            show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
            term_colors = false,       -- sets terminal colors (e.g. `g:terminal_color_0`)
            default_integrations = false,
            integrations = {
                flash = true,
                nvim_surround = true,
                which_key = true,
            },
        },
        config = function ()
            local cp = require('catppuccin.palettes').get_palette('mocha')
            local set_hl = vim.api.nvim_set_hl

            --- flash
            set_hl(0, 'FlashBackdrop', { fg = cp.overlay0 })
            set_hl(0, 'FlashLabel', { fg = cp.green, bg = cp.base, bold = true })
            set_hl(0, 'FlashMatch', { fg = cp.lavender, bg = cp.base })
            set_hl(0, 'FlashCurrent', { fg = cp.peach, bg = cp.base })
            set_hl(0, 'FlashPrompt', { fg = cp.text, bg = mantle })

            --- surround
            set_hl(0, 'NvimSurroundHighlight', { bg = darken(cp.peach, 0.6, cp.base), bold = true })
        end
    },
}
