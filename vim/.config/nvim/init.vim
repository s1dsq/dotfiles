set nocompatible            
filetype off                 

let g:mapleader="\<Space>"

" =============================================================================
" # PLUGINS
" =============================================================================
" Load Plugins
call plug#begin()

" Git 
Plug 'tpope/vim-fugitive'
" Editor 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Language specific
Plug 'sheerun/vim-polyglot'
" Commenting
Plug 'tpope/vim-commentary'
" handy mappings and mnemonics
Plug 'tpope/vim-unimpaired'
" GUI 
Plug 'gruvbox-community/gruvbox'
Plug 'altercation/vim-colors-solarized'
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Movement
Plug 'easymotion/vim-easymotion'

call plug#end() 

" -----------
" # COC 
" ----------
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
nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gy <Plug>(coc-type-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>cd :CocDiagnostics<CR>

" Coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" -----------
" # netrw
" ----------
let g:netrw_banner = 0
let g:netrw_liststyle = 0
let g:netrw_browse_split = 2
let g:netrw_winsize = 20

nnoremap <silent> <Leader>fe :Vexplore<CR>

" -----------
" # FZF
" ----------
let g:fzf_layout = {'down' : '30%'}

nnoremap <silent> <Leader>fz :FZF<CR>
nnoremap <silent> <Leader>bf :Buffers<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}

" -----------
" # Colors and Theme
" ----------
" deal with colors
if !has('gui_running')
  set t_co=256
endif
if (match($term, "-256color") != -1) && (match($term, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif

" Theme settings
execute "set background=".$BACKGROUND
colorscheme gruvbox
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_contrast_light='hard'

" Statusline
set laststatus=2
set statusline=%<\ %f\ %m%r%=\ %y\ L:\ \%l\/\%L\ C:\ \%c\ 

" =============================================================================
" # Editor settings
" =============================================================================
" detect filetype plugins and indents
filetype plugin indent on 
" try to indent automatically
set autoindent
" syntax highlighting
syntax on
" unload buffer when leaving
set hidden
" enable mouse for all modes
set mouse=a
" https://www.reddit.com/r/vim/wiki/tabstop
set tabstop=8 softtabstop=4 shiftwidth=4 expandtab
" copied text goes into "" register (default buffer for mac) 
set clipboard=unnamed 
" split vertical window to the right and below
set splitright splitbelow
" line numbering
set number relativenumber 
" write when changing buffer, read when files changes outside of vim
set autowrite autoread
" fold according to syntax
set foldmethod=syntax

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
" allows to visually select and repeat using .
vnoremap . :norm.<CR> 

" Ctrl+c as <Esc> (mapping caps-lock to control)
" can also map Ctrl+k as <Esc>
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

" Allow local customization to init.vim
let $LOCALFILE=expand("~/.init_local.vim")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
