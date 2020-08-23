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
" Plug 'ajh17/VimCompletesMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Language specific
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'leafgarland/typescript-vim'
" Commenting
Plug 'preservim/nerdcommenter'

" GUI plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'gruvbox-community/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Break bad habits (hardmode was too hard)
" Plug 'takac/vim-hardtime'


call plug#end() 

"Coc Stuff
" Plugin Settings
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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
let g:airline_theme='gruvbox'

" nerdcommenter
let g:NERDSpaceDelims = 1 " add space after delimiter


" netrw settings (builtin file manager) 
let g:netrw_banner = 0
let g:netrw_liststyle = 0
let g:netrw_browse_split = 2
let g:netrw_winsize = 20

nnoremap <silent> <Leader>fe :Vexplore<CR>

" splits 
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
noremap <Leader>, <C-w>

" deal with colors
if !has('gui_running')
  set t_co=256
endif
if (match($term, "-256color") != -1) && (match($term, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif


" Theme settings
set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark='medium'

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

set foldmethod=syntax
" set cursorline

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
" autocmd QuickFixCmdPost * copen

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
inoremap jj <ESC>
" inoremap {<CR> {<CR>}<Esc>O  " automatic curly braces
" switch spell command
nnoremap <silent> <Leader>s :set spell!<CR> 

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
