return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = {"python"},
    root_markers = { "setup.py", "requirements.txt", ".git" },
    single_file_support = true,
}
