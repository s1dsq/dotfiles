let $VD=split(&runtimepath, ',')[0]

filetype plugin indent on
syntax on

colorscheme default
set background=light

" open quickfix window automatically when it changes
augroup VIMRC
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost    l* lwindow
augroup END

nnoremap <space>v :e $MYVIMRC<CR>

set mouse=a
set expandtab softtabstop=2 shiftwidth=2
set clipboard^=unnamed,unnamedplus
set number relativenumber
set path=.,,**
set incsearch
set nohlsearch
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set laststatus=2
set ruler
set wildmenu
set autoread
set hidden
set splitright splitbelow

nnoremap Y y$
vnoremap ; :
vnoremap : ;
nnoremap ; :
nnoremap : ;

" toggle commonly used options
nnoremap yon :set number! <bar> set number?<CR>
nnoremap yor :set relativenumber! <bar> set relativenumber?<CR>
nnoremap yoh :set hlsearch! <bar> set hlsearch?<CR>
nnoremap yob :set background=<C-R>=&background == "dark" ? "light" : "dark"<CR><CR>

" quickfix list
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>

" argument list
nnoremap [a :previous<CR>
nnoremap ]a :next<CR>
nnoremap [A :first<CR>
nnoremap ]A :last<CR>

" buffers
nnoremap <BS> :b#<CR>
nnoremap g<CR> :ls<CR>:buffer<space>
nnoremap g\ :ls<CR>:vert sbuffer<space>

" finding files
nnoremap ,f :find *
nnoremap ,v :vert sfind *
nnoremap ,F :find <C-R>=fnameescape(expand('%:p:h')).'**/*'<CR>
nnoremap ,V :vert sfind <C-R>=fnameescape(expand('%:p:h')).'**/*'<CR>

" use tab to cycle completion list
inoremap <expr> <Tab> matchstr(getline('.'), '.\%' . col('.') . 'c') =~ '\k' \|\| pumvisible() ? "<C-N>" : "<Tab>"
inoremap <expr> <S-Tab> matchstr(getline('.'), '.\%' . col('.') . 'c') =~ '\k' \|\| pumvisible() ? "<C-P>" : "<S-Tab>"

