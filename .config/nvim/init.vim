call plug#begin('~/.config/nvim/plugged')

" looks
Plug 'vim-airline/vim-airline'                            " airline for vim
Plug 'ryanoasis/vim-devicons'                             " adds many icons
Plug 'airblade/vim-gitgutter'                             " git changes on left.
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " colors
Plug 'mhinz/vim-startify'                                 " start page
Plug 'tomasiser/vim-code-dark'                            " colorscheme
Plug 'cocopon/iceberg.vim'

" misc
Plug 'vimwiki/vimwiki'		" for my note taking.
Plug 'gentoo/gentoo-syntax' 	" syntax for gentoo related files

" Coding
Plug 'neoclide/coc.nvim', {'branch': 'release'} " code completion
Plug 'chiel92/vim-autoformat'                   " used to remove trailing spaces.
Plug 'honza/vim-snippets'                       " snippet supprt.
Plug 'szw/vim-maximizer'			" maximizing panel
Plug 'mfussenegger/nvim-dap' 			" Inspector for vim
Plug 'rcarriga/nvim-dap-ui' 			" UI for dap

" functions
Plug 'machakann/vim-sandwich'        " surrounding
Plug 'preservim/nerdcommenter'       " comment out things
Plug 'nvim-lua/popup.nvim' 	     " dependency of teltscope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' " replacement of ctrlp
Plug 'tpope/vim-repeat'              " repeat support for stuff
Plug 'tpope/vim-fugitive'            " Git support.
Plug 'easymotion/vim-easymotion'     " better motion!!
Plug 'godlygeek/tabular'             " for OCD people.
Plug 'dhruvasagar/vim-table-mode'    " Taking notes in vim

" trees and bars
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'preservim/tagbar'		" press <F8> to get a tagbar.

call plug#end()

colorscheme iceberg

set termguicolors
set relativenumber
set number
set shiftwidth=2
set mouse=a
set ignorecase smartcase
set noshowmode
set smartindent
set scrolloff=10

" plugin settings
source ~/.config/nvim/conf.d/*

let g:startify_custom_header = 'startify#pad(startify#fortune#boxed())'
let g:startify_lists = [
      \ { 'type': 'dir',       'header': ['   MRU @ '. getcwd()] },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]
let g:startify_commands = [
      \ {'w': ['Open Vim Wiki', ':VimwikiIndex']},
      \ ]
let g:startify_custom_indices = [
      \ 'a', 'd', 'f',  'l', ';', 'g']
let g:startify_skiplist = [
      \ '^/tmp',
      \ escape(fnamemodify($HOME, ':p'), '\') .'Documents/Personal/Wiki',
      \ escape(fnamemodify($HOME, ':p'), '\') .'Encrypted',
      \ escape(fnamemodify($HOME, ':p'), '\') .'.config/yadm/repo.git',
      \ ]

let g:Hexokinase_ftDisabled = ['css']

let g:vimwiki_list = [{'path': '~/Documents/Personal/Wiki/',
      \ 'syntax': 'markdown', 'ext': '.md'}]
" only enable vimwiki in wiki folder
let g:vimwiki_global_ext = 0

lua require("dapui").setup()
" keybindings (except for coc)
" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>tf <cmd>Telescope fd<cr>
nnoremap <leader>tg <cmd>Telescope live_grep<cr>
nnoremap <leader>tb <cmd>Telescope buffers<cr>
nnoremap <leader>th <cmd>Telescope help_tags<cr>
" nerdtree tagbar coc formatter.
nnoremap <F12> <cmd>lua require("dapui").toggle()<cr>
nnoremap <F2>  <cmd>Format<CR>
nnoremap <F8>  <cmd>TagbarToggle<CR>
nnoremap <C-n> <cmd>NERDTreeToggle<CR>
nnoremap <C-l> <cmd>NERDTreeFind<CR>
" easymotion
nmap <space>f <Plug>(easymotion-f)
nmap <space>F <Plug>(easymotion-F)
nmap <space>l <Plug>(easymotion-lineanywhere)
nmap <space>j <Plug>(easymotion-j)
nmap <space>k <Plug>(easymotion-k)
nmap <space>w <Plug>(easymotion-w)
nmap <space>W <Plug>(easymotion-W)
nmap <space>b <Plug>(easymotion-b)
nmap <space>b <Plug>(easymotion-B)
" fix intending.
vmap < <gv
vmap > >gv
" make Y behave like other Capitalized letters
nnoremap Y y$
" n/N also centered
nnoremap n nzzzv
nnoremap N Nzzzv
" undo to the last , . or !
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
" Shortcutting split navigation
map <A-h> <C-w>h
map <A-j> <C-w>j
map <A-k> <C-w>k
map <A-l> <C-w>l
map <A-H> <C-w>H
map <A-J> <C-w>J
map <A-K> <C-w>K
map <A-L> <C-w>L
map <A->> <C-w>>
map <A-<> <C-w><
" Tab shortcuts
nnoremap <A-p> :tabp<CR>
nnoremap <A-n> :tabn<CR>
" map Alt + q to exit terminal mode.
tnoremap <A-q> <C-\><C-n>
