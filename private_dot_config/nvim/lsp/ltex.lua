return {
    cmd = { "ltex-ls-plus" },
    filetypes = {"tex", "latex", "typst"},
    root_markers = { "main.typ", "main.tex", ".git" },
    settings = {
        ltex = {
            language = "auto",
            checkFrequency = "save",
            dictionary = {
                es = {
                    ":/home/okf/.config/nvim/spell/es.utf-8.add"
                },
                en = {
                    ":/home/okf/.config/nvim/spell/en.utf-8.add"
                }
            },
            disabledRules = {
                es = {
                    'MORFOLOGIK_RULE_ES'
                }
            }
        }
    }
}
