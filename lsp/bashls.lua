---@brief
---
--- https://github.com/bash-lsp/bash-language-server
---
--- `bash-language-server` can be installed via `npm`:
--- ```sh
--- npm i -g bash-language-server
--- ```
---

local cmd_path = vim.fn.exepath('bash-language-server')

return {
    cmd = { cmd_path, 'start' },
    filetypes = { 'bash', 'sh', 'zsh' },
    root_markers = { '.git' },
    single_file_support = true,
    settings = {
        bashIde = {
            globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
            shfmt = {
                path = vim.fn.exepath('shfmt'),
                binaryNextLine = true,
                ignoreEditorconfig = false,
            },
            shellcheckPath = 'shellcheck',
            shellcheckArguments = '',
        },
    },
}
