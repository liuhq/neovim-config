---@brief
---
--- https://github.com/nikeee/dot-language-server
---
--- `dot-language-server` can be installed via `npm`:
--- ```sh
--- npm install -g dot-language-server
--- ```
---

local cmd_path = vim.fn.exepath('dot-language-server')

return {
    cmd = { cmd_path, '--stdio' },
    filetypes = { 'dot' },
    root_markers = { '.git' },
    single_file_support = true,
}
