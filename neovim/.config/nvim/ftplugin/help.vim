nnoremap <buffer> <CR> <C-]>
nnoremap <buffer> <BS> <C-T>

augroup HELP
    autocmd!
    autocmd BufWinEnter <buffer> wincmd L
augroup END
