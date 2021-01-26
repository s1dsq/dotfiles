augroup VIMRC
  autocmd!
  autocmd BufWritePost .vimrc source $RC
  autocmd BufWritePost .vimrc_local source $RC
  autocmd BufRead .vim-vsf :call files#BufferSettings()
  autocmd ColorScheme * highlight LspDiagnosticsDefaultError ctermfg=DarkRed
              \ | highlight LspDiagnosticsUnderlineError ctermfg=DarkRed
              \ | highlight LspDiagnosticsDefaultHint ctermfg=Magenta
              \ | highlight LspDiagnosticsDefaultWarning ctermfg=DarkMagenta
  autocmd VimLeavePre * call sessions#MakeSession()
augroup END

colorscheme solarized
set background=light

if has('nvim')
  packadd! nvim-lspconfig
  packadd! completion-nvim
endif

let g:mapleader="\<Space>"

" custom variables
let $RC="~/.vimrc"
let $VD="~/.vim"

" basics
set hidden
set mouse=a
set expandtab tabstop=8 softtabstop=4 shiftwidth=4
set clipboard^=unnamed,unnamedplus
set splitright splitbelow
set number relativenumber
set foldmethod=syntax
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

" UI
set statusline=\ [%n]\ %<\ %f\ %m%r\ %{FugitiveStatusline()}%=\ %y\ L:\ \%l\/\%L\ C:\ \%c\ 

" remaps
nnoremap Y y$
vnoremap ; :
vnoremap : ;
nnoremap ; :
nnoremap : ;
map <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>

" moving around
nnoremap <BS> :b#<CR>
nnoremap g<CR> :ls<CR>:buffer<space>
nnoremap g\ :ls<CR>:vert sbuffer<space>
nnoremap ,f :find *
nnoremap ,v :vert sfind *
nnoremap ,F :find <C-R>=fnameescape(expand('%:p:h')).'**/*'<CR>
nnoremap ,V :vert sfind <C-R>=fnameescape(expand('%:p:h')).'**/*'<CR>

" better completion menu
inoremap <expr> <Tab> matchstr(getline('.'), '.\%' . col('.') . 'c') =~ '\k' ? "<C-N>" : "<Tab>"
inoremap <expr> <S-Tab> matchstr(getline('.'), '.\%' . col('.') . 'c') =~ '\k' ? "<C-P>" : "<S-Tab>"

" commonly accessed files
nnoremap <Leader>v :e $RC<CR>
nnoremap <leader>f :e <C-R>='$VD/ftplugin/'.&filetype.'.vim'<CR><CR>

nnoremap <leader>n :set modifiable! <bar> set modifiable?<CR>

nnoremap <leader>s :call whitespace#StripTrailingWhitespace()<CR>
nnoremap <silent> <Leader>p :call files#SimpleFiles()<CR>

nnoremap <up> :copen<CR>
nnoremap <down> :cclose<CR>
nnoremap <left> :lclose<CR>
nnoremap <right> : lopen<CR>

if has('nvim')
    tnoremap <Esc> <C-\><C-N>
    autocmd TermOpen * startinsert

    tnoremap <A-h> <C-\><C-N><C-w>h
    tnoremap <A-j> <C-\><C-N><C-w>j
    tnoremap <A-k> <C-\><C-N><C-w>k
    tnoremap <A-l> <C-\><C-N><C-w>l
    inoremap <A-h> <C-\><C-N><C-w>h
    inoremap <A-j> <C-\><C-N><C-w>j
    inoremap <A-k> <C-\><C-N><C-w>k
    inoremap <A-l> <C-\><C-N><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
endif

" plugins
" git stuff
noremap Gb :Git blame<CR>
nnoremap Gg mS:Ggrep!
nnoremap <leader>G :Git<CR>
nnoremap <Leader>gh :diffget LOCAL<CR>
nnoremap <Leader>gl :diffget REMOTE<CR>

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" lsp
if has('nvim')
    nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gh     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
    lua << EOF
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

    require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }

    local cmd = {"node", "~/.nvm/versions/node/v12.18.3/lib/node_modules/@angular/language-server/index.js", "--stdio", "--tsProbeLocations", "" , "--ngProbeLocations", ""}
    require'lspconfig'.angularls.setup{ on_attach=require'completion'.on_attach }
    require'lspconfig'.angularls.setup{
      cmd = cmd,
      on_new_config = function(new_config,new_root_dir)
        new_config.cmd = cmd
      end,
    }
EOF
endif

" Allow local customizations
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
