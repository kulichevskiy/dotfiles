filetype plugin on                  " required
syntax enable
set background=dark
colorscheme gruvbox

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'klen/python-mode'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'vimwiki/vimwiki'
Plugin 'tpope/vim-repeat'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'

call vundle#end()

" Set a leader key
:let mapleader = ","
let g:mapleader = ","

" Easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Insert a current timestamp
map <Leader>ts <esc>:$pu=strftime('%n[%a, %d %b %Y %T %z]')<CR>

" Toggle a tree
map <C-n> :NERDTreeToggle<CR>

vnoremap <Leader>s :sort<CR>

set nocompatible
set clipboard=unnamed
set bs=2
set autoindent
set autoread
set cursorline
set display+=lastline
set encoding=utf8
set expandtab
set hlsearch
set ignorecase
set laststatus=2
set lazyredraw
set linebreak
set nu
set number
set relativenumber
set ruler
set shiftround
set shiftwidth=4
set showmatch
set smartcase
set ts=4
set wildmenu
set wrap
syntax enable
syntax on

" enable all Python syntax highlighting features
let python_highlight_all = 1

"
" VimWiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md', 'diary_rel_path' : '/diary'}]
:map <Leader><Space> <Plug>VimwikiToggleListItem

" YouCompleteMe Settings
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" python with virtualenv support
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(open(activate_this).read(), dict(__file__=activate_this))
EOF
