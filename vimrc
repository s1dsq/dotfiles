" custom variables {{{

let $RC="~/.vimrc"
let $VD="~/.vim"
let g:mapleader="\<Space>"

" }}}

" VIMRC {{{

nnoremap <Leader>v :e $RC<CR>

augroup VIMRC
  autocmd!
  autocmd BufWritePost .vimrc source $RC
  autocmd BufWritePost .vimrc_local source $RC
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
    exe '!git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac'
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
call minpac#add('Raimondi/delimitMate')
call minpac#add('bronson/vim-visual-star-search')
call minpac#add('neovim/nvim-lspconfig', {'type': 'opt'})
call minpac#add('ledger/vim-ledger')
call minpac#add('tommcdo/vim-exchange')
call minpac#add('tommcdo/vim-lion')

command! PackUpdate call minpac#update()
command! PackClean  call minpac#clean()
command! PackStatus call minpac#status()

if has('nvim')
  packadd! nvim-lspconfig
endif

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
set undofile undodir=~/.vim/undodir
set noswapfile nobackup
set shortmess+=I                                                                " don't show startup message
set showmatch
set nohlsearch
set linebreak
set diffopt+=algorithm:patience
set grepprg=git\ grep\ --no-index\ --exclude-standard\ --column\ -n
set grepformat=%f:%l:%c:%m

" }}}

" statusline {{{

set statusline=\ [%n]                                                          " buffer #
set statusline+=\ %<\ %f                                                       " relative path
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
nnoremap g<CR> :ls<CR>:buffer<space>
nnoremap g\ :ls<CR>:vert sbuffer<space>
nnoremap ,f :find *
nnoremap ,v :vert sfind *
nnoremap ,F :find <C-R>=fnameescape(expand('%:p:h')).'**/*'<CR>
nnoremap ,V :vert sfind <C-R>=fnameescape(expand('%:p:h')).'**/*'<CR>
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

if has('nvim')
    tnoremap <C-[> <C-\><C-N>
    autocmd TermOpen * startinsert

    tnoremap <A-h> <C-\><C-N><C-w>h
    tnoremap <A-j> <C-\><C-N><C-w>j
    tnoremap <A-k> <C-\><C-N><C-w>k
    tnoremap <A-l> <C-\><C-N><C-w>l
endif

" }}}

" plugin config {{{

" fugitive
noremap Gb :Git blame<CR>
nnoremap Gg mS:Ggrep!
nnoremap G<space> :Git<CR>

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

" lsp {{{

if has('nvim')
    nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gh     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
    lua << EOF
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end


    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = {
            severity_limit = "Warning",
        },
        -- Enable virtual text, override spacing to 4
        virtual_text = {
          spacing = 4,
          prefix = '~',
        },
        signs = {
            priority = "Warning",
        },
        -- Disable a feature
        update_in_insert = false,
      }
    )

    local custom_lsp_attach = function(client)
        vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    end
    require'lspconfig'.tsserver.setup({ on_attach = custom_lsp_attach })

    local cmd = {"node", "~/.nvm/versions/node/v12.18.3/lib/node_modules/@angular/language-server/index.js", "--stdio", "--tsProbeLocations", "" , "--ngProbeLocations", ""}
    -- require'lspconfig'.angularls.setup{ on_attach=require'completion'.on_attach }
    require'lspconfig'.angularls.setup{ on_attach = custom_lsp_attach }
    require'lspconfig'.angularls.setup{
      cmd = cmd,
      on_new_config = function(new_config,new_root_dir)
        new_config.cmd = cmd
      end,
    }
EOF
endif

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

let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif

" }}}

" vim:fdm=marker ft=vim et sts=2 sw=2
