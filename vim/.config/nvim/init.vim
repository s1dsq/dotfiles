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
Plug 'ajh17/VimCompletesMe'
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
Plug 'mcchrish/nnn.vim'

" Fuzzy finder
Plug 'junegunn/fzf'

call plug#end() 

" Plugin Settings
" Vimtex
let g:tex_flavor='latex'
if has('nvim')
	let g:vimtex_compiler_progname = 'nvr'	
endif
if executable('zathura')
	let g:vimtex_view_method='zathura'
endif

" airline
let g:airline_powerline_fonts=1

" airline themes
let g:airline_theme='solarized_flood'

" nerdcommenter
let g:NERDSpaceDelims = 1 " add space after delimiter

" deal with colors
if !has('gui_running')
  set t_co=256
endif
if (match($term, "-256color") != -1) && (match($term, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif


" Theme settings
set background=light
let base16colorspace=256
colorscheme base16-solarized-light

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

set cursorline

" Ctrl+c as <Esc> (mapping caps-lock to control)
" can also mat Ctrl+k as <Esc>
nnoremap <C-c> <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>
snoremap <C-c> <Esc>
xnoremap <C-c> <Esc>
cnoremap <C-c> <Esc>
onoremap <C-c> <Esc>
lnoremap <C-c> <Esc>
tnoremap <C-c> <Esc>

" Ins-mode complettion
" https://www.vi-improved.org/recommendations/
" file names
inoremap <silent> ,f <C-x><C-f> 
" keywords (cur + incl files)
inoremap <silent> ,i <C-x><C-i> 
" whole lines
inoremap <silent> ,l <C-x><C-l> 
" keywords (cur file)
inoremap <silent> ,n <C-x><C-n> 
" omni-completion
inoremap <silent> ,o <C-x><C-o> 
" tags
inoremap <silent> ,t <C-x><C-]> 
" user-defined
inoremap <silent> ,u <C-x><C-u> 
" vim-commands
inoremap <silent> ,v <C-x><C-v> 

" compiling and quickfix stuff
" (https://gist.github.com/ajh17/a8f5f194079818b99199)

" automatic quickfix after make
autocmd QuickFixCmdPost * copen


" =============================================================================
" # Keyboard shortcuts
" =============================================================================
inoremap jj <ESC>
" inoremap {<CR> {<CR>}<Esc>O  " automatic curly braces
" switch spell command
nnoremap <silent> <Leader>s :set spell!<CR> 

" run make 
nnoremap <Leader>c :make<CR>

" allows to visually select and repeat using .
vnoremap . :norm.<CR> 

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
