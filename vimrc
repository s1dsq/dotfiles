let g:did_install_default_menus = 1  " avoid stupid menu.vim (saves ~100ms)

if exists('g:vscode')
    nnoremap Y y$
    vnoremap ; :
    vnoremap : ;
    nnoremap ; :
    nnoremap : ;

    nnoremap <silent> <c-k> <Cmd>call VSCodeCall('editor.action.showHover')<CR>
    nnoremap <silent> gD <Cmd>call VSCodeCall('editor.action.goToImplementation')<CR>
    nnoremap <silent> gr <Cmd>call VSCodeCall('references-view.find')<CR>
    nnoremap <silent> gR <Cmd>call VSCodeCall('references-view.findImplementations')<CR>
    " nnoremap <silent> <delete> <Cmd>call VSCodeCall('editor.debug.action.toggleBreakpoint')<CR>
    " nnoremap <silent> gO <Cmd>call VSCodeCall('workbench.action.gotoSymbol')<CR>
    " nnoremap <silent> gO <Cmd>call VSCodeCall('outline.focus')<CR>
    " nnoremap <silent> z/ <Cmd>call VSCodeCall('workbench.action.showAllSymbols')<CR>
    nnoremap <silent> - <Cmd>call VSCodeCall('workbench.files.action.showActiveFileInExplorer')<CR>
    " nnoremap <silent> <c-b> <Cmd>call VSCodeCall('workbench.action.showAllEditorsByMostRecentlyUsed')<CR>

    " nnoremap <silent> UD <Cmd>call VSCodeCall('git.openChange')<CR>
    " nnoremap <silent> UW <Cmd>call VSCodeCall('git.stage')<CR>
    nnoremap <silent> UB <Cmd>call VSCodeCall('gitlens.toggleFileBlame')<CR>
    finish
endif

let g:spacegray_low_contrast = 0
let g:polyglot_disabled = ['go']

packadd! ale
packadd! vim-polyglot
packadd! commentary
packadd! dispatch
packadd! goyo
packadd! repeat
packadd! surround
packadd! undotree
packadd! unimpaired
packadd! vim-dirvish
packadd! vim-git
packadd! vim-qf
packadd! vim-sneak

filetype plugin indent on                                                       
syntax on                               
let g:mapleader="\<Space>"

" custom variables
let $RC="~/.vimrc"
let $VD="~/.vim"

" basics 
set autoindent                          
set hidden                                                                      
set mouse=a                                                                     
set expandtab                                                                   
set tabstop=8 softtabstop=4 shiftwidth=4                                        
set clipboard=unnamed
set splitright splitbelow                                                       
set number relativenumber                                                       
set autowrite autoread                                                          
set foldmethod=syntax                                                           
set path=.,,**
set wildmenu                                                                    
set wildignore+=**/node_modules/**,**/out-tsc/**
set undofile undodir=~/.vim/undodir                                             " save undos
set noswapfile nobackup                                                         " remove annoyance
set shortmess+=I                                                                " don't show startup message
set showmatch                                                                   
set hlsearch incsearch                                                          
set linebreak
set wildcharm=<C-z>
set diffopt+=algorithm:patience
set grepprg=git\ grep\ --no-index\ --exclude-standard\ --column\ -n
set grepformat=%f:%l:%c:%m
if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
endif

" cursor in vim modes
if !has('nvim')
  " Insert mode
  let &t_SI = "\<Esc>[6 q"
  " Replace mode
  if has("patch-7.4-687")
    let &t_SR = "\<Esc>[4 q"
  endif
  " Normal mode
  let &t_EI = "\<Esc>[2 q"
endif

" UI
set laststatus=2
set statusline=%<\ [%n]\ %f\ %m%r%=\ %y\ L:\ \%l\/\%L\ C:\ \%c\ 
set colorcolumn=80

" remaps
nnoremap Y y$
vnoremap ; :
vnoremap : ;
nnoremap ; :
nnoremap : ;
nnoremap <C-h> <C-w>h                                                           
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" moving around
nnoremap <BS> :b#<CR>
nnoremap g<CR> :ls<CR>:buffer<space>
nnoremap gs :ls<CR>:sbuffer<space>
nnoremap g\ :ls<CR>:vert sbuffer<space>
nnoremap ,f :find *
nnoremap ,s :sfind *
nnoremap ,v :vert sfind *
nnoremap ,F :find <C-R>=fnameescape(expand('%:p:h')).'**/*'<CR>
nnoremap ,S :sfind <C-R>=fnameescape(expand('%:p:h')).'**/*'<CR>
nnoremap ,V :vert sfind <C-R>=fnameescape(expand('%:p:h')).'**/*'<CR>

" External Grep (faster than just running grep)
command! -nargs=+ -complete=file_in_path -bar Grep cgetexpr system(&grepprg . ' <args>')
nnoremap ,g :Grep

" better completion menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" commonly accessed files
nnoremap <Leader>v :e $RC<CR>
nnoremap <leader>f :e <C-R>='$VD/ftplugin/'.&filetype.'.vim'<CR><CR>

" utils
nnoremap gb :echo system('git rev-parse --abbrev-ref @ <bar> tr -d "\n"')<CR>
nnoremap gB :silent !tig blame % +<C-r>=expand(line('.'))<CR><CR>:silent redraw!<CR>
nnoremap gO :silent !tig<CR>:silent redraw!<CR>
nnoremap <Leader>gh :diffget LOCAL<CR>
nnoremap <Leader>gl :diffget REMOTE<CR>

" plugins
" sneak
let g:sneak#s_next = 1
let g:sneak#label = 1

" undotree
nnoremap <F5> :UndotreeToggle<CR>

" vim-qf
nmap \q <Plug>(qf_qf_toggle)

" ale
highlight link ALEWarningSign Todo
highlight link ALEErrorSign WarningMsg
highlight link ALEVirtualTextWarning Todo
highlight link ALEVirtualTextInfo Todo
highlight link ALEVirtualTextError WarningMsg
highlight ALEError guibg=#330000
highlight ALEWarning guibg=#333300
let g:ale_sign_error = "✖"
let g:ale_sign_warning = "⚠"
let g:ale_sign_info = "i"

" use dirvish instead of netrw
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" vimrc specific
augroup VIMRC
  autocmd!
  autocmd BufWritePost .vimrc source $RC
  autocmd BufWritePost .vimrc_local source $RC
augroup END

" Allow local customization to init.vim
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
