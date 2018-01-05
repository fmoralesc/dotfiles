" vim: set fdm=marker :

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins: {{{1
call plug#begin('~/.config/nvim/bundle')
" Filetypes: {{{2
" Essential: {{{3
Plug 'dag/vim-fish'
Plug 'klen/python-mode'
Plug 'vim-latex/vim-latex'
Plug 'vimoutliner/vimoutliner'
" Devel: {{{3
let g:plug_url_format = 'git@github.com:%s.git'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'vim-pandoc/vim-pandoc-syntax'
"Plug 'vim-pandoc/vim-bibliographer'
"Plug 'git@github.com:fmoralesc/vim-beyul.git'
"Plug 'git@github.com:fmoralesc/vim-tutor-mode.git'
"Plug 'git@github.com:vim-pandoc/vim-criticmarkup.git'
"Plug '~/.vim/plugged/vim-commonmark'
unlet g:plug_url_format

" Utilities: {{{2
" Devel: {{{3
let g:plug_url_format = 'git@github.com:%s.git'
Plug 'fmoralesc/worldslice'
Plug 'fmoralesc/vim-extended-autochdir'
"Plug 'fmoralesc/vim-pad', {'branch': 'devel'}
Plug 'fmoralesc/nlanguagetool'
"Plug 'fmoralesc/nvim-logic'
"Plug 'fmoralesc/nvimfs'
"Plug 'fmoralesc/vim-autogit'
unlet g:plug_url_format
" Essential {{{3
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/nerdcommenter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'justinmk/vim-gtfo'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
Plug 'Shougo/deoplete.nvim'
Plug 'tpope/vim-fugitive'
" others: {{{3
Plug 'chrisbra/NrrwRgn'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'dahu/vim-fanfingtastic'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"Plug 'mhinz/vim-grepper'
"Plug 'benekastah/neomake'
"Plug 'kana/vim-smartword'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'justinmk/vim-sneak'
"Plug 'simnalamburt/vim-mundo'
"Plug 'junegunn/vim-easy-align'

" Colorschemes: {{{2
Plug 'chriskempson/base16-vim'
"Plug 'sjl/badwolf'
"Plug 'morhetz/gruvbox'
" Devel {{{3
"Plug 'tomasr/molokai' | Plug 'fmoralesc/molokayo'
"Plug 'git@github.com:plan9-for-vimspace/acme-colors.git'
"}}}2
call plug#end()

" Options: {{{2
" fzf: {{{3
if !has('nvim')
    nnoremap <f25> :silent! :<C-u>History<CR>
    nnoremap <C-ñ> :silent :<C-u>Lines<cr>
else
    nnoremap <f25> :silent! :<C-u>History<cr>
    nnoremap <F26> :silent! :<C-u>Lines<cr>
endif
nnoremap <C-p> :silent :<C-u>Files<CR>

let g:sneak#streak = 1

" pymode {{{3
let g:pymode_lint = 0
let g:pymode_options_colorcolumn = 0

" vim-pad {{{3
"let g:pad#dir = '~/Documents/Notas'
"let g:pad#search_backend = 'rg'

" vim-pandoc: {{{3
let g:pandoc#compiler#command = 'panzer'
let g:pandoc#formatting#mode = "hA"
let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1
let g:pandoc#folding#level = 2
let g:pandoc#folding#mode = "relative"
let g:pandoc#after#modules#enabled = ["nrrwrgn", "tablemode", "ultisnips", "deoplete"]
let g:pandoc#completion#bib#mode = 'citeproc'
let g:pandoc#syntax#newlines = 0

" NrrRgn: {{{3
noremap <leader>nn :NR<CR>
" deoplete {{{3
let g:deoplete#enable_at_startup = 1
"}}}1

" UI: {{{1
" Theme: {{{2
set co=130 lines=40

" Colors {{{3
set background=dark
set termguicolors

au Colorscheme * hi! link MatchParen Special
au Colorscheme * hi! link TabLineSel SLIdentifier
au Colorscheme * hi! link TabLine StatusLine
au Colorscheme * hi! link TabLineFill StatusLine
au Colorscheme * hi! link FoldColumn EndOfBuffer
au Colorscheme * hi! EndOfBuffer guifg=#383838
au Colorscheme * hi! link VertSplit NonText
colorscheme base16-darktooth
hi! Cursor guibg=#f92672 guifg=#ffffff gui=bold cterm=bold ctermbg=197 ctermfg=15
hi! CursorInsert guibg=#0077ff guifg=#ffffff ctermbg=39  ctermfg=15
hi! CursorVisual guibg=#2077ff guifg=#ffffff ctermbg=38 ctermfg=15
hi! CursorReplace guibg=#ff2000 guifg=#ffffff ctermbg=196 ctermfg=15
set guicursor=
	    \n:block-Cursor,
            \a:block-blinkon0,
            \i:ver25-blinkwait200-blinkoff150-blinkon200-CursorInsert,
            \r:blinkwait200-blinkoff150-blinkon200-CursorReplace,
            \v:CursorVisual,
	    \c:ver25-blinkon300-CursorInsert
"}}}2
" Elements: {{{2
" No initial message
set shortmess+=I
" No toolbars or scrollbars
set guioptions-=T
set guioptions-=r
set guioptions-=L
" Folding {{{2
function! NeatFoldText() "
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '/' . printf("%10s", lines_count . ' lines') . ' /'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()
" }}}2
" Statusline: {{{2

function! StatusDir()
    if &buftype != "nofile"
        let d = expand("%:p:~:h")
        if d != fnamemodify(getcwd(), ":~")
            return expand("%:p:.:h").'/'
        else
            return ''
        endif
    else
        return ''
    endif
endfunction

function! OtherBuffers()
    let buffers_txt = ""
    redir => buffers_txt
    silent ls
    redir END
    let lines = []
    for line in split(buffers_txt, "\n")
        let bufnr = split(line)[0]
        if bufnr != bufnr("%")
            call add(lines, split(line)[0])
        endif
    endfor
    return lines
endfunction

function! StatusOtherBuffers()
    return join(map(OtherBuffers(), '"·".v:val'), ' ')
endfunction

function! PWD()
    return fnamemodify(getcwd(), ":~")
endfunction

let g:worldslice#config = [
            \ '+(@:)', ['%{PWD()}', 'Special'],
	    \ '+(:)', ['%n', 'Number'],
	    \ '+(:)', ["%{expand('%:h')!=''? StatusDir(): ''}", 'Directory'],
	    \ ["%{expand('%:h')!=''? expand('%:t'): '[unnamed]'}", 'Identifier'],
	    \ ['%m%r', 'Boolean'],
	    \ ["%{fugitive#head()!=''? '@': ''}", 'Delimiter'], ['%{fugitive#head()}', 'VCS'],
	    \ ' ', ['%{StatusOtherBuffers()}', 'Character'],
	    \ ' %=\',
	    \ ["%{&ft=='pandoc'?wordcount().words.':':''}"],
	    \ ['%{&fenc}', 'Constant'],
	    \ '+(:)', ['%{&ft}', 'Type'],
	    \ '+(:)', ['%{&fo}', 'Function'],
	    \ '+(:)', ["%{&spell?&spl:''}", 'SpellBad'],
	    \ [' %l,%c', 'Number']
	    \ ]
call worldslice#init()

" Scroll {{{2
set scrolloff=1
noremap <expr> H 'H' . eval('&scrolloff') . '<C-u>'
noremap <expr> L 'L' . eval('&scrolloff') . 'j'
" Mouse {{{2
set mouse=a
" }}}1

" Search: {{{1
set ignorecase
set smartcase
" }}}1

" Misc: {{{1
set keymodel=startsel,stopsel
set viewoptions-=options,folds
set inccommand=split
set undofile
set completeopt-=preview
" }}}1

" Commands: {{{1
command! SynName echo synIDattr(synID(line("."), col("."), 1), "name")
command! SynStack echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
command! SynTrans echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), "name")
command! FileTree leftabove 30vsplit . | map <buffer> <CR> <nop>
command! -nargs=1 Dict call jobstart(['goldendict', '<args>'])
" }}}1

" Mappings: {{{1
"
let g:maplocalleader=",,"

" change current dir {{{2
noremap <leader>cd :cd %:h<CR>
noremap <leader>ld :lcd %:h<CR>

" movement {{{2
noremap <up> gk
noremap <down> gj
noremap <leader>j 5j
noremap <leader>k 5k

" buffer mappings {{{2
noremap <C-b>d :bdelete<CR>
noremap <C-b>w :bwipe<CR>
noremap <C-b>! :bwipe!<cr>

" spelling {{{2
" Suggest spellings
inoremap <C-s> <C-X>s
nnoremap c<C-s> <esc>i<C-x>s
" Goto next misspelling
nnoremap <C-s>x ]s
nnoremap <C-s>z [s
" Goto prev mispelling


