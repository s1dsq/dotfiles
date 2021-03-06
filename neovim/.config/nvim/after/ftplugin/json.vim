setlocal foldmethod=syntax

" User-defined command for running prettier on select lines (default all)
:command! -buffer -range=% Prettier let b:winview = winsaveview() |
  \ silent! execute <line1> . "," . <line2> . "!prettier --single-quote --stdin-filepath " . expand('%') | 
  \ call winrestview(b:winview)

" Autocommand for running prettier on buffer saves
augroup Prettify
  autocmd!
  autocmd BufWritePre <buffer> Prettier
augroup END

