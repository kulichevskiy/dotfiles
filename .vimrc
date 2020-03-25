
syntax enable
set background=dark
colorscheme gruvbox

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'digitaltoad/vim-pug'
Plugin 'jiangmiao/auto-pairs'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdcommenter'
Plugin 'VundleVim/Vundle.vim'
Plugin 'klen/python-mode'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'vimwiki/vimwiki'
Plugin 'tpope/vim-repeat'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic' " syntax checking
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-fugitive'
Plugin 'sheerun/vim-polyglot' " syntax highlighting 
Plugin 'dense-analysis/ale' " async linter
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mattn/emmet-vim' " html constructor
Plugin 'jceb/vim-orgmode' " org-mode

" dependancies for org-mode
Plugin 'utl.vim'
Plugin 'taglist.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-speeddating'
Plugin 'chrisbra/nrrwrgn'
Plugin 'itchyny/calendar.vim'
Plugin 'SyntaxRange'
" end dependancies for org-mode

packloadall
silent! helptags ALL

" Set a leader key
:let mapleader = ","
let g:mapleader = ","

" Easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Insert a current timestamp
map <Leader>ts <esc>:$put=strftime('%c')<CR>

" Toggle a tree
map <C-n> :NERDTreeToggle<CR>

vnoremap <Leader>s :sort<CR>


set autoindent
set smartindent
set smarttab
set expandtab
set autoread
set bs=2
set clipboard=unnamed
set cursorline
set display+=lastline
set encoding=utf8
set expandtab
set hlsearch
set ignorecase
set laststatus=2
set lazyredraw
set linebreak
set linebreak 
set nocompatible
set nolist
set nu
set number
set relativenumber
set ruler
set shiftround
set shiftwidth=4
set showmatch
set sts=4
set sw=4
set smartcase
set splitbelow
set splitright
set ts=4
set tw=79
set wildmenu
set wrap
syntax enable
syntax on

" enable all Python syntax highlighting features
let python_highlight_all = 1
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>1'

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" VimWiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md', 'diary_rel_path' : '/diary'}]
:map <Leader><Space> <Plug>VimwikiToggleListItem


" python with virtualenv support
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(open(activate_this).read(), dict(__file__=activate_this))
EOF

" NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$'] 
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" Polyglot
let g:polyglot_disabled = ['python']

" ESLint / Prettier
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['eslint']
" Fix files automatically on save
let g:ale_fix_on_save = 1

" Emmet
let g:user_emmet_leader_key=','

" NeoVim Python
let g:python3_host_prog = '/usr/local/bin/python3' 
let g:python_host_prog = '/usr/bin/python' 
