" vim: set fdm=marker :

let $SUDO_ASKPASS = '/usr/share/git-cola/bin/ssh-askpass'

let $PATH .= ':~/.local/bin'

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
Plug 'python-mode/python-mode', {'branch': 'develop'}
Plug 'vim-latex/vim-latex'
Plug 'vimoutliner/vimoutliner'
Plug 'leanprover/lean.vim'
" Devel: {{{3
let g:plug_url_format = 'git@github.com:%s.git'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'fmoralesc/vim-bibliographer'
unlet g:plug_url_format

" Utilities: {{{2
" Devel: {{{3
let g:plug_url_format = 'git@github.com:%s.git'
Plug 'fmoralesc/worldslice'
Plug 'fmoralesc/vim-extended-autochdir'
Plug 'fmoralesc/nlanguagetool'
unlet g:plug_url_format
" Essential {{{3
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/nerdcommenter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tweekmonster/wstrip.vim'
Plug 'justinmk/vim-gtfo'
Plug 'junegunn/fzf', { 'do': 'yes \| ./install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'lambdalisue/gina.vim'

" others: {{{3
Plug 'chrisbra/NrrwRgn'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'dahu/vim-fanfingtastic'
"Plug 'brennier/quicktex'
Plug 'Konfekt/FastFold'

" Colorschemes: {{{2
Plug 'chriskempson/base16-vim'
call plug#end()

" Options: {{{2
" fzf: {{{3
function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let width = float2nr(&columns - (&columns * 2 / 10))
  let height = (&lines/5)*3
  let y = &lines - height - (&lines/5)
  let x = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': y,
        \ 'col': x,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

nnoremap <F25> :silent! :<C-u>History<cr>
nnoremap <C-p> :silent :<C-u>Files<CR>

" pymode {{{3
let g:pymode = 1
let g:pymode_options = 1
let g:pymode_rope = 0

" vim-pandoc: {{{3
let g:pandoc#command#use_terminal = 1
let g:pandoc#command#latex_engine = 'latexmk'
let g:pandoc#command#prefer_pdf = 1
let g:pandoc#formatting#mode = "hA"
let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1
let g:pandoc#folding#level = 2
let g:pandoc#folding#mode = "relative"
let g:pandoc#folding#fold_yaml = 1
let g:pandoc#after#modules#enabled = ["nrrwrgn"]
let g:pandoc#completion#bib#mode = 'citeproc'
let g:pandoc#syntax#newlines = 0

" NrrRgn: {{{3
noremap <leader>nn :NR<CR>
" deoplete {{{3
let g:deoplete#enable_at_startup = 1

"nvim's lsp: {{{3
call lsp#add_filetype_config({
			\ 'filetype': 'python',
			\ 'name': 'pyls',
			\ 'cmd': 'pyls'
			\})

call lsp#add_filetype_config({
			\ 'filetype': 'tex',
			\ 'name': 'texlab',
			\ 'cmd': 'texlab'
			\})

autocmd Filetype python,tex setl omnifunc=lsp#omnifunc
nnoremap <silent> ;dc :call lsp#text_document_declaration()<CR>
nnoremap <silent> ;df :call lsp#text_document_definition()<CR>
nnoremap <silent> ;h  :call lsp#text_document_hover()<CR>
nnoremap <silent> ;i  :call lsp#text_document_implementation()<CR>
nnoremap <silent> ;s  :call lsp#text_document_signature_help()<CR>
nnoremap <silent> ;td :call lsp#text_document_type_definition()<CR>
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
au Colorscheme * hi! link VertSplit NonText
colorscheme base16-atelier-forest
hi! Normal guibg=#1a1a1a
hi! link CursorLine Error
hi! Cursor guibg=#f92672 guifg=#ffffff gui=bold cterm=bold ctermbg=197 ctermfg=15
hi! CursorInsert guibg=#0077ff guifg=#ffffff ctermbg=39  ctermfg=15
hi! CursorVisual guibg=#2077ff guifg=#ffffff ctermbg=38 ctermfg=15
hi! CursorReplace guibg=#ff2000 guifg=#ffffff ctermbg=196 ctermfg=15
hi! ColorColumn guibg=#181818
hi! link LspDiagnosticsError ErrorMsg
hi! link LspDiagnosticsWarning WarningMsg
hi! WarningMsg guifg=#ff8000

set guicursor=
	    \n:block-Cursor,
            \a:block-blinkon0,
            \i:ver25-blinkwait200-blinkoff150-blinkon200-CursorInsert,
            \r:blinkwait200-blinkoff150-blinkon200-CursorReplace,
            \v:CursorVisual,
	    \c:ver25-blinkon300-CursorInsert
"}}}2
" Elements: {{{2
set signcolumn=auto:4
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
    return pathshorten(fnamemodify(getcwd(), ":~"))
endfunction

let g:worldslice#config = [
            \ '+(@:)', ['%{PWD()}', 'Special'],
	    \ '+(:)', ['%n', 'Number'],
	    \ '+(:)', ["%{expand('%:h')!=''? StatusDir(): ''}", 'Directory'],
	    \ ["%{expand('%:h')!=''? expand('%:t'): '[unnamed]'}", 'Identifier'],
	    \ ['%m%r', 'Boolean'],
	    \ ["%{gina#component#repo#name()!=''? '@': ''}", 'Delimiter'],
	    \ ['%{gina#component#repo#branch()}', 'VCS'],
	    \ ['%{gina#component#status#preset()}', 'DiffChange'],
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
"set completeopt=noinsert,menuone,noselect
set undofile
set noequalalways
set pumblend=10
if &startofline
" don't reset the cursor upon returning to a buffer:
augroup StayPut
  au!
  autocmd BufLeave * set nostartofline | 
      \ autocmd StayPut CursorMoved,CursorMovedI * set startofline | autocmd! StayPut CursorMoved,CursorMovedI
augroup END
endif
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

" pum wildmenu
cnoremap <expr> <Up>    pumvisible() ? "\<Left>"  : "\<Up>"
cnoremap <expr> <Down>  pumvisible() ? "\<Right>" : "\<Down>"
cnoremap <expr> <Left>  pumvisible() ? "\<Up>"    : "\<Left>"
cnoremap <expr> <Right> pumvisible() ? "\<Down>"  : "\<Right>"

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

" common blunders {{{2
augroup vim_blunders
au! FileType vim iabbrev PLug Plug
augroup END
