set shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab

" User-defined command for running gofmt on select lines (default all)
:command! -buffer -range=% Gofmt let b:winview = winsaveview() |
  \ silent! execute <line1> . "," . <line2> . "!gofmt " | 
  \ call winrestview(b:winview)

" User-defined command for running goimport on select lines (default all)
:command! -buffer -range=% Goimport let b:winview = winsaveview() |
  \ silent! execute <line1> . "," . <line2> . "!goimports " | 
  \ call winrestview(b:winview)

" Autocommand for running gofmt and goimport on buffer saves
augroup Goupdate
  autocmd!
  autocmd BufWritePre <buffer> Gofmt
  autocmd BufWritePre <buffer> Goimport
augroup END
