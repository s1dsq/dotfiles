setlocal shiftwidth=2

" User-defined command for running prettier on select lines (default all)
:command! -buffer -range=% Prettier let b:winview = winsaveview() |
  \ silent! execute <line1> . "," . <line2> . "!prettier --single-quote --stdin-filepath " . expand('%') | 
  \ call winrestview(b:winview)
