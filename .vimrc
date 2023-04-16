runtime! debian.vim

if has("syntax")
  syntax on
endif

"set background=dark

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

call plug#begin()
Plug 'tpope/vim-fugitive'
call plug#end()

"Some display settings
"colorscheme monokai
"Highlight horizontal and vertical line over cursor
set cursorline
set incsearch
set smartcase
set showmatch
set hlsearch

"Use cscope database variable
cs add $CSCOPE_DB

"Space in normalmode -> :
nnoremap <space> :

"open file under cursor
nnoremap <leader>f yiw :cs find f <c-r>" <CR>
"search for global under cursor
nnoremap <leader>g yiw:cs find g <c-r>" <CR>
"search for string word under cursor
nnoremap <leader>e yiw:cs find e <c-r>" <CR>
"search for calling functions for word under cursor
nnoremap <leader>c yiw:cs find c <c-r>" <CR>

"F2 to resize current window to 10 lines 
"leader-F2 will do the same horizontalyl
map <F2> :res 10<CR>
map <leader><F2> :vertical res 50<CR>

"F3 to edit vimrc
map <F3> :e $HOME/.vim/.vimrc <CR>

"leader+w to see changes in current file
nnoremap <leader>w :w !diff % - <CR>

"Show commands on status line
set showcmd

"use relativenumbers
set number relativenumber
