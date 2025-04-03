setlocal formatlistpat=^\\s*[-+/]\\s*
setlocal formatoptions+=croqn
setlocal autoindent
setlocal textwidth=80
setlocal linebreak
setlocal foldmethod=expr
setlocal foldlevel=4
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
