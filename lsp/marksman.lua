---@brief
---
--- https://github.com/artempyanykh/marksman
---
--- Marksman is a Markdown LSP server providing completion, cross-references, diagnostics, and more.
---
--- Pre-built binaries can be downloaded from https://github.com/artempyanykh/marksman/releases
---

local cmd_path = vim.fn.exepath('marksman')

return {
    cmd = { cmd_path, 'server' },
    filetypes = { 'markdown', 'markdown.mdx' },
    root_markers = { '.marksman.toml', '.git' },
    single_file_support = true,
}
