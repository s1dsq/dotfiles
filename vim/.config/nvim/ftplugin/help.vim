nnoremap <buffer> <CR> <C-]>
nnoremap <buffer> <BS> <C-T>
nnoremap <buffer> q :q<CR>

augroup HELP
    autocmd!
    autocmd BufWinEnter <buffer> wincmd L
augroup END
