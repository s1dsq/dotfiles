let $VD=split(&runtimepath, ',')[0]

filetype plugin indent on
syntax on

colorscheme default
set background=light

augroup VIMRC
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost    l* lwindow
augroup END

nnoremap <space>v :e $MYVIMRC<CR>

set mouse=a
set expandtab tabstop=8 softtabstop=4 shiftwidth=4
set clipboard^=unnamed,unnamedplus
set number relativenumber
set path=.,,**
set incsearch
set hlsearch
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

nnoremap <BS> :b#<CR>
nnoremap g<CR> :ls<CR>:buffer<space>
nnoremap g\ :ls<CR>:vert sbuffer<space>
nnoremap ,f :find *
nnoremap ,v :vert sfind *
nnoremap ,F :find <C-R>=fnameescape(expand('%:p:h')).'**/*'<CR>
nnoremap ,V :vert sfind <C-R>=fnameescape(expand('%:p:h')).'**/*'<CR>

" use tab to cycle completion list
inoremap <expr> <Tab> matchstr(getline('.'), '.\%' . col('.') . 'c') =~ '\k' \|\| pumvisible() ? "<C-N>" : "<Tab>"
inoremap <expr> <S-Tab> matchstr(getline('.'), '.\%' . col('.') . 'c') =~ '\k' \|\| pumvisible() ? "<C-P>" : "<S-Tab>"

