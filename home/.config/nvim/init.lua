--- vim: foldmethod=marker

local execute = vim.api.nvim_command
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

--- packer {{{3
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
	execute [[packadd packer.nvim]]
end

cmd([[
	augroup Packer
	autocmd!
	autocmd BufWritePost init.lua PackerCompile
	augroup end
]])

local use = require('packer').use

--- plugins {{{1
require('packer').startup(function()
	--- package manager
	use 'wbthomason/packer.nvim'
	--- colorscheme
	use 'chriskempson/base16-vim'
	--- ui
	use 'dstein64/nvim-scrollview'
	use 'itchyny/lightline.vim'
	use {'nvim-telescope/telescope.nvim', 
		requires = {
				{'nvim-lua/popup.nvim'},
				{'nvim-lua/plenary.nvim'}}
	}
	use {"nvim-telescope/telescope-frecency.nvim",
		requires = {'tami5/sql.nvim'},
		config = function()
		    require"telescope".load_extension("frecency")
		end
	}
	use 'hrsh7th/nvim-compe'
	use 'GoldsteinE/compe-latex-symbols'
	--- filetypes
	use 'vim-pandoc/vim-pandoc'
	use {'vim-pandoc/vim-pandoc-syntax', branch= 'minimized'}
	use 'dag/vim-fish'
	use {'vim-latex/vim-latex', ft='tex'}
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	-- use {'PieterjanMontens/vim-pipenv',
	--	requires = {'plytophogy/vim-virtualenv'}
	--}
	--- utilities
	use 'neovim/nvim-lspconfig'
	use 'kabouzeid/nvim-lspinstall'
	use 'justinmk/vim-gtfo'
	use 'justinmk/vim-dirvish'
	use 'airblade/vim-rooter'
	use 'tpope/vim-eunuch'
	use 'tpope/vim-commentary'
	use 'ntpeters/vim-better-whitespace'
	--- helpers
	use 'rafcamlet/nvim-luapad'
	use 'tjdevries/colorbuddy.nvim'
end)

--- ui options {{{1
opt.mouse = 'a'

opt.columns = 130
opt.lines = 40
opt.foldcolumn = '2'

OverrideColors = function()
	local hg_links = {
		MatchParen = 'Special',
		TabLine = 'StatusLine',
		TabLineSel = 'SLIdentifier',
		TabLineFill = 'StatusLine',
		FoldColumn = 'EndOfBuffer',
		VertSplit = 'NonText',
		CursorLine = 'Error'
	}	
	for key, val in pairs(hg_links) do
		execute(table.concat({'hi! link', key, val}, ' '))
	end
	cmd([[
	hi! Cursor guibg=#f92672 guifg=#ffffff gui=bold cterm=bold ctermbg=197 ctermfg=15
	hi! CursorInsert guibg=#0077ff guifg=#ffffff ctermbg=39  ctermfg=15
	hi! CursorVisual guibg=#2077ff guifg=#ffffff ctermbg=38 ctermfg=15
	hi! CursorReplace guibg=#ff2000 guifg=#ffffff ctermbg=196 ctermfg=15
	hi! ColorColumn guibg=#181818
	]])
end

execute[[au! Colorscheme * lua OverrideColors()]]
execute[[colorscheme base16-onedark]]

opt.guicursor =
	'n:block-Cursor,'..
	'a:block-blinkon0,'..
	'i:ver25-blinkwait200-blinkoff150-blinkon200-CursorInsert,'..
	'r:blinkwait200-blinkoff150-blinkon200-CursorReplace,'..
	'v:CursorVisual,c:ver25-blinkon300-CursorInsert'

--- statusline {{{1

cmd[[
function! RelDir()
    if &buftype != "nofile"
        let d = expand("%:p:~:h")
        if d != fnamemodify(getcwd(), ":~") && d != '~'
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
    return join(map(OtherBuffers(), '"".v:val'), ' ')
endfunction

function! PWD()
    return pathshorten(fnamemodify(getcwd(), ":~"))
endfunction
]]

g.lightline = {  
	colorscheme = 'ayu_mirage';
	active = { 
		left = { 
			{ 'mode', 'paste' },
			{ 'pwd', 'reldir', 'gitbranch', 'readonly', 'filename', 'modified', 'otherbuffers' }
		},
	};
	component = {
		percent = "%{&ft=='pandoc'?wordcount().words:''}",
		reldir = "%{expand('%:h')!=''?RelDir():''}"
	};
	component_function = {
		gitbranch = 'fugitive#head',
		pwd = 'PWD',
		reldir = 'RelDir',
		otherbuffers = 'StatusOtherBuffers'
	};
	mode_map = { n = 'N', i = 'I', R = 'R', c = ':', v = 'V', t = 'T' };
}

--- Highlight on yank {{{3
execute([[ autocmd TextYankPost * silent! lua vim.highlight.on_yank() ]])

--- treesitter {{{1
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true
	},
	indent = {
		enable = true
	}
}

--- completion {{{1
opt.completeopt = {'menuone', 'noselect'}

require('compe').setup {
	enabled = true;
	preselect = 'enable';
	source = {
		path = true;
		buffer = true;
		nvim_lsp = true;
		emoji = true;
		latex_symbols = true;
	};
}

--- telescope {{{1
require('telescope').setup{
	defaults = {
		mappings = {
			i = {
				["<esc>"] = require('telescope.actions').close
			},
		},
		generic_sorter = require'telescope.sorters'.get_fzy_sorter,
		file_sorter = require'telescope.sorters'.get_fzy_sorter,
		winblend = 20;
		show_line = false;
		borderchars = {
			prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
			results = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
			preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
		};
	}
}

vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files<cr>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<leader><C-p>', '<cmd>Telescope file_browser<cr>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<f25>', '<cmd>Telescope frecency<cr>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<f26>', '<cmd>Telescope buffers<cr>', {noremap=true, silent=true})

--- rooter {{{1
g['rooter_change_directory_for_non_project_files'] = 'current'
g['rooter_silent_chdir'] = 1

--- lsp {{{1
local nvim_lsp = require('lspconfig')
local on_attach = function(_client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = { noremap=true, silent=true }
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', 
		'<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', 
		'<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', 
		'<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', 
		'<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>',
		'<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa',
		'<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr',
		'<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl',
		'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D',
		'<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn',
		'<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',
		'<cmd>lua vim.lsp.buf.references()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca',
		'<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e',
		'<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d',
		'<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d',
		'<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q',
		'<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

local servers = { 'pyright', 'texlab', 'pyls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

--- vim-pandoc {{{1
g['pandoc#syntax#flavor'] = 'minimized'
g['pandoc#folding#level'] = 2
g['pandoc#formatting#mode'] = 'hA'
g['pandoc#formatting#smart_autoformat_on_cursormoved'] = 1
g['pandoc#biblio#sources'] = 'bcgyG'
g['pandoc#command#use_terminal'] = 1
g['pandoc#command#latex_engine'] = 'latexmk'

--- options {{{1
opt.keymodel = {'startsel', 'stopsel'}

opt.ignorecase = true
opt.smartcase = true

opt.inccommand = 'split'

opt.undofile = true
opt.equalalways = false
opt.pumblend = 10

opt.hidden = true

opt.tabstop = 4
opt.shiftwidth = 4

--- mappings {{{1
g.mapleader = ','
g.maplocalleader = ',,'

cmd([[
" pum wildmenu
cnoremap <expr> <Up>    pumvisible() ? "\<Left>"  : "\<Up>"
cnoremap <expr> <Down>  pumvisible() ? "\<Right>" : "\<Down>"
cnoremap <expr> <Left>  pumvisible() ? "\<Up>"    : "\<Left>"
cnoremap <expr> <Right> pumvisible() ? "\<Down>"  : "\<Right>"

" movement {{{2
noremap <up> gk
noremap <down> gj
noremap <leader>j 5j
noremap <leader>k 5k

" buffer mappings {{{2
noremap <C-b>d :bdelete<CR>
noremap <C-b>w :bwipe<CR>
noremap <C-b>! :bwipe!<cr>

]])
