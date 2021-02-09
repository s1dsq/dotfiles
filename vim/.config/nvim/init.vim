" custom variables {{{

let $VD=split(&runtimepath, ',')[0]
let g:mapleader="\<Space>"

" }}}

" VIMRC {{{

nnoremap <Leader>v :e $MYVIMRC<CR>

augroup VIMRC
  autocmd!
  autocmd BufWritePost init.vim source $MYVIMRC
  autocmd BufWritePost init_local.vim source $MYVIMRC
  autocmd BufRead .vim-vsf :call files#BufferSettings()
  autocmd VimLeavePre * call sessions#MakeSession()
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" }}}

" plugins {{{

try
    packadd minpac
catch
    exe '!git clone https://github.com/k-takata/minpac.git ' stdpath('config').'/pack/minpac/opt/minpac'
    packadd minpac
endtry

call minpac#init()
call minpac#add('lifepillar/vim-solarized8')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-sensible')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-git')
call minpac#add('Raimondi/delimitMate')
call minpac#add('bronson/vim-visual-star-search')
call minpac#add('neovim/nvim-lspconfig', {'type': 'opt'})
call minpac#add('ledger/vim-ledger')
call minpac#add('tommcdo/vim-exchange')
call minpac#add('tommcdo/vim-lion')
call minpac#add('srstevenson/vim-picker')
call minpac#add('justinmk/vim-sneak')

command! PackUpdate call minpac#update()
command! PackClean  call minpac#clean()
command! PackStatus call minpac#status()

packadd! nvim-lspconfig

" }}}

" settings {{{

set mouse=a
set expandtab tabstop=8 softtabstop=4 shiftwidth=4
set clipboard^=unnamed,unnamedplus
set number relativenumber
set path=.,,**
set wildmode=list:full
set wildignore+=**/node_modules/**,**/out-tsc/**
set wildignorecase
set undofile undodir=~/.config/nvim/undodir
set noswapfile nobackup
set shortmess+=I                                                                " don't show startup message
set showmatch
set inccommand=nosplit
set linebreak
set diffopt+=algorithm:patience
set grepprg=git\ grep\ --no-index\ --exclude-standard\ --column\ -n
set grepformat=%f:%l:%c:%m

" }}}

" statusline {{{

set statusline=\ [%n]                                                          " buffer number
set statusline+=\ %<\ %f                                                       " file name
set statusline+=\ %m                                                           " modified flag
set statusline+=%r                                                             " readonly flag
set statusline+=\ %y                                                           " filetype
set statusline+=%=                                                             " seperator
set statusline+=\ %{FugitiveStatusline()}                                      " git branch
set statusline+=\ L:\ \%l\/\%L                                                 " current/total lines
set statusline+=\ C:\ \%c\                                                     " column number

" }}}

" remaps {{{

nnoremap Y y$
vnoremap ; :
vnoremap : ;
nnoremap ; :
nnoremap : ;
map <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>

" }}}

" finding files {{{

nnoremap <BS> :b#<CR>
nnoremap ,e :edit <C-R>=fnameescape(expand('%:p:h')).'/'<CR>
nnoremap <silent> <Leader>p :call files#SimpleFiles()<CR>

" }}}

" buffer and windows {{{{

set hidden
set splitright splitbelow

" meta key bindings to quickly switch windows
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" }}}

" misc {{{

" edit filetype settings
nnoremap <leader>f :e <C-R>='$VD/after/ftplugin/'.&filetype.'.vim'<CR><CR>

nnoremap <leader>n :setlocal modifiable! <bar> setlocal modifiable?<CR>

nnoremap <leader>s :call whitespace#StripTrailingWhitespace()<CR>

" }}}

" quickfix/location list {{{

augroup QuickFix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost    l* lwindow
augroup END

nnoremap <up> :copen<CR>
nnoremap <down> :cclose<CR>
nnoremap <left> :lclose<CR>
nnoremap <right> :lopen<CR>

" }}}

" terminal {{{

tnoremap <C-[> <C-\><C-N>
autocmd TermOpen * startinsert

tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l

" }}}

" plugin config {{{

" vim-sneak
let g:sneak#label = 1
let g:sneak#s_next = 0

" }}}

" completion {{{

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" omni-completion
inoremap <silent> ,o <C-x><C-o>

" use tab to cycle completion list
inoremap <expr> <Tab> matchstr(getline('.'), '.\%' . col('.') . 'c') =~ '\k' \|\| pumvisible() ? "<C-N>" : "<Tab>"
inoremap <expr> <S-Tab> matchstr(getline('.'), '.\%' . col('.') . 'c') =~ '\k' \|\| pumvisible() ? "<C-P>" : "<S-Tab>"

" }}}

" colorscheme {{{

set termguicolors
set background=light
silent! colorscheme solarized8

augroup Colors
    autocmd!
    autocmd ColorScheme * highlight LspDiagnosticsDefaultError ctermfg=DarkRed
                \ | highlight LspDiagnosticsUnderlineError ctermfg=DarkRed
                \ | highlight LspDiagnosticsDefaultHint ctermfg=Magenta
                \ | highlight LspDiagnosticsDefaultWarning ctermfg=DarkMagenta
augroup END

" }}}

" Allow local customizations {{{

let $LOCALFILE=expand("~/.init_local.vim")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif

" }}}

" vim:fdm=marker ft=vim et sts=2 sw=2
