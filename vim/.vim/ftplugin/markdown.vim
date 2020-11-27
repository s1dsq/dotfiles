setlocal autoindent
setlocal spell
setlocal linebreak
setlocal wrap
setlocal nonumber
setlocal norelativenumber 
setlocal suffixesadd=.md

nnoremap gp :silent %!prettier --stdin-filepath %<CR>
