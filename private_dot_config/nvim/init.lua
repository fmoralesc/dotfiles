-- vim: fdm=marker
-- lazy.nvim {{{4
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- basic settings {{{1

vim.g.mapleader = " "

vim.o.termguicolors = true
vim.o.shortmess = 'ltToOCFIW'
vim.o.title = true
vim.o.signcolumn = 'yes:1'
vim.o.foldcolumn = 'auto:3'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.breakindent = true
vim.o.keymodel = 'startsel,stopsel'
vim.o.inccommand = "split"

-- plugins {{{1
require('lazy').setup({
    -- checker = { enabled = true },
    dev = {
        path = "~/.config/nvim/dev"
    },
    spec = {
        -- colorschemes {{{2
        {
            "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            opts = {},
            config = function()
                require("tokyonight").setup()
            end
        },
        -- {
        --     'uloco/bluloco.nvim',
        --     lazy = false,
        --     priority = 1000,
        --     dependencies = { 'rktjmp/lush.nvim' },
        --     config = function()
        --         -- your optional config goes here, see below.
        --     end,
        -- },
        -- essentials {{{2
        {
            'fmoralesc/vim-extended-autochdir',
        },
        {
            'jghauser/mkdir.nvim'
        },
        {
            'stevearc/oil.nvim',
            opts = {
                delete_to_trash = true,
            },
        },
        {
            "echasnovski/mini-git",
            version = "*",
            main = 'mini.git',
            config = function()
                require('mini.git').setup()
            end
        },
        -- filetypes {{{2
        {
            'fmoralesc/pandocer.nvim',
            ft = {"markdown", "typst"},
            dev=true,
            opts = {}
        },
        {
            'kaarmu/typst.vim',
            ft='typst'
        },
        -- misc {{{2
        {
            'folke/snacks.nvim',
            priority = 1000,
            lazy = false,
            opts = {
                quickfile = {},
                input = {},
                picker = {},
                notifier = {},
                lazygit = {},
                scroll = {},
                statuscolumn = {},
                image = {
                    math = {
                        enabled = true,
                    }
                },
            },
        },
        -- ui {{{2
        {
            "folke/noice.nvim",
            event = "VeryLazy",
            dependencies = {
                "MunifTanjim/nui.nvim",
            },
            config = function()
                require("noice").setup {
                    lsp = {
                        override = {
                            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                            ["vim.lsp.util.stylize_markdown"] = true,
                        },
                        signature = {
                            enabled = true,
                        }
                    },
                    presets = {
                        bottom_search = false, -- use a classic bottom cmdline for search
                        command_palette = true, -- position the cmdline and popupmenu together
                        long_message_to_split = true, -- long messages will be sent to a split
                        inc_rename = false, -- enables an input dialog for inc-rename.nvim
                        lsp_doc_border = false, -- add a border to hover docs and signature help
                    },
                }
            end
    	},
        {
            'stevearc/quicker.nvim',
            event = "FileType qf",
            opts = {},
        },
        {
            'echasnovski/mini.statusline',
            version = false,
            config = function()
                require("mini.statusline").setup()
            end,
        },
        {
            'akinsho/bufferline.nvim',
            event = 'Colorscheme',
            branch = "main",
            dependencies = 'nvim-tree/nvim-web-devicons',
            config = function()
                require('bufferline').setup()
            end,
        },
        'dstein64/nvim-scrollview',
        {
            "catgoose/nvim-colorizer.lua",
            event = "BufReadPre",
            config = function()
                require("colorizer").setup({
                    user_default_options = {
                        names = false,
                    },
                })
            end
        },
        -- editing {{{2
        {
            'luiscassih/AniMotion.nvim',
            event = 'VeryLazy',
            config = true
        },
        {
            'machakann/vim-sandwich',
        },
        {
            'echasnovski/mini.pairs',
            version = false,
            config = function()
                require("mini.pairs").setup()
            end
        },
        {
            'echasnovski/mini.ai',
            version = false,
            config = function()
                require("mini.ai").setup()
            end
        },
                {
            'saghen/blink.cmp',
            lazy = false,
            dependencies = {
                'rafamadriz/friendly-snippets',
            },
            version = "*",
            opts = {
                keymap = { preset = 'super-tab' },
                appearance = {
                    use_nvim_cmp_as_default = true,
                    nerd_font_variant = 'mono'
                },
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },
            },
            opts_extend = { "sources.default" }
        },
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            config = function()
                require('nvim-treesitter.configs').setup {
                    modules = {},
                    ensure_installed = {'regex', 'lua', 'bibtex', 'fish', 'latex', 'markdown', 'markdown_inline', 'typst'},
                    sync_install = false,
                    auto_install = true,
                    ignore_install = {},
                    highlight = {
                        enable = true,
                    },
                    incremental_selection = {enable = true},
                }
            end
        },
        {'nvimdev/lspsaga.nvim',
            event = 'LspAttach',
            config = function()
                require('lspsaga').setup({})
            end,
            dependencies = {
                'nvim-treesitter/nvim-treesitter', -- optional
                'nvim-tree/nvim-web-devicons',     -- optional
            }
        },
    },
})

--lsp {{{1
vim.lsp.enable('marksman')
vim.lsp.enable('luals')
vim.lsp.enable('pyright')
vim.lsp.enable('ltex')
vim.lsp.enable('tinymist')
vim.lsp.enable('texlab')

vim.diagnostic.config({
    virtual_lines = true,
})
-- }}}
-- colorscheme {{{1
vim.api.nvim_create_autocmd("Colorscheme", {
    callback = function()
        vim.cmd [[
        highlight! MiniStatuslineFilename guifg=#eeeeee guibg=#16171c
        highlight! MiniStatuslineDevinfo guibg=#16171c guifg=#d62e09
        highlight! MiniStatuslineFileinfo guibg=#16171c guifg=#ee4080 gui=italic
        hi! MiniStatuslineModeCommand guibg=#ff8827 gui=NONE
        hi! MiniStatuslineModeNormal guibg=#2788ff gui=NONE
        hi! MiniStatuslineModeInsert guibg=#b0ff27 gui=NONE
        hi! Folded guifg=#8080aa guibg=bg gui=italic
        hi! link BufferlineFill Delimiter
        hi! link NoicePopup Pmenu
        ]]
    end
})
vim.cmd.colorscheme('tokyonight-night')

-- keymaps {{{1

vim.keymap.set('n', 'gh', '<cmd>set invhlsearch<cr>')

-- local fzf = require("fzf-lua")
vim.keymap.set('n', '<leader>b', '<cmd>lua Snacks.picker.buffers()<cr>')
vim.keymap.set('n', '<C-o>', '<cmd>lua Snacks.picker.recent()<cr>')
vim.keymap.set('n', '<leader>p', '<cmd>lua Snacks.picker.git_files()<cr>')

vim.keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<cr>')
vim.keymap.set('n', '<leader>a', '<cmd>Lspsaga code_action<cr>')

vim.keymap.set('n', '<leader>-', '<cmd>Oil .<cr>')

vim.keymap.set('n', 'gt', '<cmd>lua Snacks.terminal.toggle()<cr>')
vim.keymap.set('n', '<leader>gg', '<cmd>silent lua Snacks.lazygit()<cr>')
vim.keymap.set('t', '``', '<C-\\><C-n>')

-- menu {{{1
--
vim.cmd([[
try
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.-2-
catch /E5113/
endtry
]])
--}}}

