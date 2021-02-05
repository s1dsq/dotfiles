setlocal spell
setlocal suffixesadd=.md
setlocal textwidth=80

nnoremap gp :silent %!prettier --stdin-filepath %<CR>
