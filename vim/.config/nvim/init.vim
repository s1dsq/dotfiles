set nocompatible            
let g:mapleader="\<Space>"

let $MYVIMRC="~/.config/nvim/init.vim"
let $MYVIMDIR="~/.config/nvim"

" source on save
autocmd BufWritePost init.vim source $MYVIMRC
autocmd BufWritePost .init_local.vim source $MYVIMRC

" Theme settings
set background=dark
colorscheme spacegray
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'

" =============================================================================
" # Editor settings
" =============================================================================
filetype plugin indent on               " detect filetype plugins and indents
syntax on                               
set autoindent                          
set hidden                              " unload buffer when leaving
set mouse=a                             " enable mouse for all modes
set expandtab                           " use spaces instead of tab
set tabstop=8 softtabstop=4 shiftwidth=4        " https://www.reddit.com/r/vim/wiki/tabstop
set clipboard=unnamed                   " copied text goes into "" register (default clipboard for mac) 
set splitright splitbelow               " split vertical window to the right and below
set number relativenumber               " line numbering
set autowrite autoread                  " write when changing buffer, read when files changes outside of vim
set foldmethod=syntax                   " fold according to syntax
set path=.,,**                          " search relative to current file and directory
set undofile undodir=~/.vim/undodir     " save undos
set noswapfile nobackup                 " remove annoyance
set shortmess+=I                        " don't show startup message
set showmatch                           " show matching braces

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
" allows to visually select and repeat using .
vnoremap . :norm.<CR> 

" Very handy mappings
vnoremap ; :
vnoremap : ;
nnoremap ; :
nnoremap : ;

" Quick movement between windows
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" resize windows quickly
noremap <silent> <C-Left> :vertical resize -5<CR>
noremap <silent> <C-Right> :vertical resize +5<CR>
noremap <silent> <C-Up> :resize +5<CR>
noremap <silent> <C-Down> :resize -5<CR>

" commonly accessed files
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <leader>f :e <C-R>='$MYVIMDIR/ftplugin/'.&filetype.'.vim'<CR><CR>

" =============================================================================
" # PLUGINS
" =============================================================================

" -----------
" # sneak
" ----------
let g:sneak#s_next = 1
let g:sneak#label = 1

" -----------
" # undotree
" ----------
nnoremap <F5> :UndotreeToggle<CR>

" -----------
" # fugitive
" ----------
nnoremap <Leader>g :G<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gh :diffget //2<CR>
nnoremap <Leader>gl :diffget //3<CR>

" -----------
" # FZF
" ----------
" system fzf
set rtp+=~/.fzf
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = {'down' : '30%'}

nnoremap <silent> <Leader>e :FZF<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}

" Statusline
set laststatus=2
set statusline=%<\ %f\ %m%r%=\ %y\ L:\ \%l\/\%L\ C:\ \%c\ 

" Allow local customization to init.vim
let $LOCALFILE=expand("~/.init_local.vim")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
