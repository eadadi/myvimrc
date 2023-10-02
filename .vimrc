runtime! debian.vim

set nocompatible
syntax enable
filetype plugin on

set path=*
set path+=.
set path+=**
set complete-=i "This makes vim autocomplete avoid searching in included files

set wildmenu
set wildignore+=*.o,*.obj,*.axf,*.bin,*.pdf,*.su,*.src,*.d,*.map,*.objdump,*.zip,*.elf,*.ld,*.mk,*.swp,tags
set wildignore+=*.out
set wildmode=list:longest,list:full

"make sure backspace acts normal
set backspace=indent,eol,start

"set background=dark

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'lervag/vimtex'
call plug#end()

"Some display settings
colorscheme desert
set cursorline
set incsearch
set smartcase
set showmatch
set hlsearch

"Use cscope database variable
if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   "set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif


"Space in normalmode -> :
nnoremap <space> :

"open file under cursor
"nnoremap <leader>f by3w :cs find f <c-r>" <CR>
"search for string word under cursor
"nnoremap <leader>e yiw:cs find e <c-r>" <CR>
"search for calling functions for word under cursor
"nnoremap <leader>c yiw:cs find c <c-r>" <CR>
"leader-g to shortcut git usage
nnoremap <leader>g :Git 

"F3 to edit vimrc
map <F3> :e $HOME/.vim/.vimrc <CR>

"Show commands on status line
set showcmd

"use relativenumbers
set number relativenumber

"use Ag to grep
set grepprg=ag

" https://www.integralist.co.uk/posts/vim/
" FZF (search files)
"
" Shift-Tab to select multiple files
"
" Ctrl-t = tab
" Ctrl-x = split
" Ctrl-v = vertical
"
" We also set FZF_DEFAULT_COMMAND in ~/.bashrc
" Also we use --ignore-dir multiple times there
" Using --hidden to allow searching hidden directories like .github
" The --hidden still respects .ignore where we ignore things like .git
" NOTE: you need --path-to-ignore ~/.ignore otherwise ag only uses local ignore ./.ignore
map <leader>f :FZF<CR>
map <leader>b :Buffers?<CR>
map <leader>G :GFiles!?<CR>
map <leader>w :Windows<CR>
map <leader>t :Ag<CR>
map <leader><leader>c :!repo_init<CR>:cs reset<CR>

"This map does the following: yank the word the cursor is on, then open a new
"tab and go to for the yank word as a tag
map <leader>] yiw:tabnew<CR>:tag <C-r>"<CR>

"vimlatex config
let g:vimtex_view_method = 'zathura'
