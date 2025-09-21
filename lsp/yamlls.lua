return {
    single_file_support = true,
    settings = {
        yaml = {
            format = { enable = false },
            schemas = {
                ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
            },
        },
    },
}
