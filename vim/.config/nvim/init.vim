set nocompatible            
filetype off                 

let g:mapleader="\<Space>"
" let g:maplocalleader="\<Space>"

" =============================================================================
" # PLUGINS
" =============================================================================
" Load Plugins
call plug#begin()

" Git plugins
Plug 'tpope/vim-fugitive'

" Editor plugins
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clangd-completer --go-completer --rust-completer' }
Plug 'Raimondi/delimitMate' " close quotes, brackets automatically

" Language specific
Plug 'lervag/vimtex', { 'for': 'tex' }

" Commenting
Plug 'preservim/nerdcommenter'

" GUI plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'

" Fuzzy finder
Plug 'junegunn/fzf'

call plug#end() 

" Plugin Settings
" YCM
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/.ycm_extra_conf.py'
let g:ycm_clangd_binary_path = '/usr/local/opt/llvm/bin/clangd'
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" Vimtex
let g:tex_flavor='latex'
if has('nvim')
	let g:vimtex_compiler_progname = 'nvr'	
endif
if executable('zathura')
	let g:vimtex_view_method='zathura'
endif

if !exists('g:ycm_semantic_triggers')
	let g:ycm_semantic_triggers = {}
endif
au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme

" airline
let g:airline_powerline_fonts=1

" airline themes
let g:airline_theme='base16_gruvbox_dark_hard'

" nerdcommenter
let g:NERDSpaceDelims = 1 " add space after delimiter

" deal with colors
if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif
" Gruvbox theme
" let g:gruvbox_contrast_dark='hard'
" let g:gruvbox_contrast_light='hard'
set background=dark
let base16colorspace=256
colorscheme base16-gruvbox-dark-hard 

" =============================================================================
" # Editor settings
" =============================================================================
filetype plugin indent on 
set autoindent

syntax on
set mouse=a

" https://www.reddit.com/r/vim/wiki/tabstop
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

set clipboard=unnamed " copied text goes into "" register (default buffer for mac) 
set guifont=Monaco:h14
set textwidth=80

" set smarttab
" set smartindent " check if this necessary, remove if not
set smartcase
set cindent

" split vertical window to the right and below
set splitright 
set splitbelow

" line numberring
set number
set relativenumber 

" update when editing a file in editor other than vim
set autowrite
set autoread
" set cursorline " hightlight current line

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
inoremap jj <ESC>
" inoremap {<CR> {<CR>}<Esc>O  " automatic curly braces
nnoremap <Leader>s :set spell!<CR> " switch spell command

vnoremap . :norm.<CR> " allows to visually select and repeat using .

" Toogle Wrapping with leader + w
noremap <Leader>w :call ToggleWrap()<CR>
function WrapOn()
	setlocal wrap linebreak " words are not broken and displayed on next line instead
	set display+=lastline " prevents long lines to be displayed as @
	set virtualedit= " allows editing anywhere in the file, even empty spaces
	noremap  <buffer> <silent> <Up>   g<Up>
  	noremap  <buffer> <silent> <Down> g<Down>
  	noremap  <buffer> <silent> <Home> g<Home>
  	noremap  <buffer> <silent> <End>  g<End>
  	inoremap <buffer> <silent> <Up>   <C-o>gk
  	inoremap <buffer> <silent> <Down> <C-o>gj
  	inoremap <buffer> <silent> <Home> <C-o>g<Home>
  	inoremap <buffer> <silent> <End>  <C-o>g<End>
endfunction
function WrapOff()
	setlocal nowrap
	set virtualedit=
	silent! nunmap <buffer> <Up>
	silent! nunmap <buffer> <Down>
  	silent! nunmap <buffer> <Home>
	silent! nunmap <buffer> <End>
  	silent! iunmap <buffer> <Up>
  	silent! iunmap <buffer> <Down>
  	silent! iunmap <buffer> <Home>
  	silent! iunmap <buffer> <End>
endfunction
function ToggleWrap()
	if &wrap
		echo "Wrap Off"
		call WrapOff()
	else
		echo "Wrap On"
		call WrapOn()
	endif
endfunction
call WrapOn()
