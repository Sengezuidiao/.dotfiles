set autochdir
set number
set cursorline
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=5
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
" set noshowmode
set ignorecase
set smartcase
set shortmess+=c
set completeopt=longest,noinsert,menuone,noselect,preview
set lazyredraw
set visualbell
set hlsearch
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ==================== Basic Mappings ====================
let mapleader=" "
" noremap ; :
nnoremap <leader>q :q<CR>
nnoremap <leader>s :w<CR>
" Search
noremap <LEADER><CR> :nohlsearch<CR>


" ==================== Insert Mode Cursor Movement ====================
inoremap <C-a> <ESC>A
      
" ==================== Command Mode Cursor Movement ====================
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <c-b> <left>
cnoremap <c-f> <right>
cnoremap <m-b> <s-left>
cnoremap <m-w> <s-right>

" ==================== Window management ====================
" Use <space> + new arrow keys for moving the cursor around windows
noremap <LEADER>w <C-w>w
noremap <LEADER><Up> <C-w>k
noremap <LEADER><Down> <C-w>j
noremap <LEADER><Left> <C-w>h
noremap <LEADER><Right> <C-w>l
