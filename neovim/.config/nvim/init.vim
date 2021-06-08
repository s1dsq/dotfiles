" custom variables {{{
let $VD=split(&runtimepath, ',')[0]
let g:mapleader="\<Space>"
let g:notes_dir="~/Nextcloud/Notes/"
" }}}

" VIMRC {{{
nnoremap <Leader>v :e $MYVIMRC<CR>

augroup VIMRC
  autocmd!
  autocmd BufWritePost init.vim source $MYVIMRC
  autocmd BufWritePost .init_local.vim source $MYVIMRC
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
call minpac#add('Raimondi/delimitMate')
call minpac#add('SirVer/ultisnips')
call minpac#add('hrsh7th/nvim-compe')
call minpac#add('justinmk/vim-dirvish')
call minpac#add('justinmk/vim-sneak')
call minpac#add('neovim/nvim-lspconfig')
call minpac#add('numToStr/FTerm.nvim')
call minpac#add('nvim-lua/plenary.nvim')
call minpac#add('nvim-lua/popup.nvim')
call minpac#add('nvim-telescope/telescope.nvim')
call minpac#add('tommcdo/vim-exchange')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-eunuch')
call minpac#add('tpope/vim-git')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-sensible')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('whiteinge/diffconflicts')

command! PackStatus call minpac#status()

nnoremap <F1> :call minpac#update()<CR>
nnoremap <F2> :call minpac#clean()<CR>

if has('nvim-0.5')
  lua require('lspsetup')
  lua require('compesetup')
  lua require('telescopesetup')
  lua require('ftermsetup')
endif
" }}}

" settings {{{
set mouse=a
set expandtab softtabstop=2 shiftwidth=2
set clipboard^=unnamed,unnamedplus
set number relativenumber
set path=.,,**
set wildignore+=**/node_modules/**,**/out-tsc/**
set wildignorecase
set undofile undodir=~/.config/nvim/undodir
set noswapfile nobackup
set shortmess+=I                                                                " don't show startup message
set showmatch
set nohlsearch
set inccommand=nosplit
set linebreak
set diffopt+=algorithm:patience
set lazyredraw
set pumblend=15
set pumheight=10

" use rg for improved grepping
if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif
" }}}

" statusline {{{
" copied from https://gitlab.com/yorickpeterse/dotfiles/
" :help vim.lsp.diagnostic.get_count()
function! init#LspWarnings() abort
  let l:warnings = luaeval('vim.lsp.diagnostic.get_count(0, [[Warning]])')

  if l:warnings > 0
    return printf("\u2002W: %d\u2002", warnings)
  endif

  return ''
endfunction

function! init#LspErrors() abort
  let l:errors = luaeval('vim.lsp.diagnostic.get_count(0, [[Error]])')

  if l:errors > 0
    return printf("\u2002E: %d\u2002", errors)
  endif

  return ''
endfunction

set statusline=\ [%n]                                                          " buffer number
set statusline+=\ %<\ %f                                                       " file name
set statusline+=\ %m                                                           " modified flag
set statusline+=%r                                                             " readonly flag
set statusline+=\ %y                                                           " filetype
set statusline+=%=                                                             " seperator
set statusline+=%#WhiteOnYellow#%{init#LspWarnings()}%*                        " LSP Warning count
set statusline+=%#WhiteOnRed#%{init#LspErrors()}%*                             " LSP Error count
set statusline+=\ L:\ \%l\/\%L                                                 " current/total lines
set statusline+=\ C:\ \%c\                                                     " column number
" }}}

" tabline {{{
" copied from https://gitlab.com/yorickpeterse/dotfiles/
function! init#Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .': '
    let s .= (bufname != '' ? fnamemodify(bufname, ':t') . ' ' : '[No Name] ')

    if bufmodified
      let s .= '[+] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  return s
endfunction

set tabline=%!init#Tabline()
" }}}

" remaps {{{
nnoremap Y y$
vnoremap ; :
vnoremap : ;
nnoremap ; :
nnoremap : ;
" }}}

" files {{{
nnoremap <BS> :buffer#<CR>
nnoremap ,m :!mkdir -p %:h<CR>
nnoremap ,e :edit <C-R>=fnameescape(expand('%:p:h')).'/'<CR>

" dotfiles repo
nnoremap ,d :lua require('telescopesetup').search_dotfiles()<CR>

" scratch notes to jot down stuff
" abbrev month name-date-year
nnoremap <silent> <leader>s :exec 'edit ~/scratch/' . strftime("%b-%d-%Y") . '.scratch'<CR>
nnoremap ,s :lua require('telescopesetup').search_scratch()<CR>

" notes
nnoremap <leader>n :edit <C-R>=expand(g:notes_dir)<CR>
nnoremap ,n :lua require('telescopesetup').search_notes()<CR>
" }}}

" buffer and windows {{{
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
nnoremap <leader>w :call whitespace#StripTrailingWhitespace()<CR>
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

" netrw browser mapping
let g:loaded_netrwPlugin = 1
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())<CR>
" }}}

" completion {{{
set completeopt=menuone,noinsert,noselect

" nvim-compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
" }}}

" colorscheme {{{
set termguicolors
colorscheme paper
" }}}

" Allow local customizations {{{
let $LOCALFILE=expand("~/.init_local.vim")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
" }}}

" vim:fdm=marker ft=vim et sts=2 sw=2
