---@brief
---
--- https://taplo.tamasfe.dev/cli/usage/language-server.html
---
--- Language server for Taplo, a TOML toolkit.
---
--- `taplo-cli` can be installed via `cargo`:
--- ```sh
--- cargo install --features lsp --locked taplo-cli
--- ```
---

local cmd_path = vim.fn.exepath('taplo')

return {
    cmd = { cmd_path, 'lsp', 'stdio' },
    filetypes = { 'toml' },
    root_markers = { '.git' },
    single_file_support = true,
}
