let g:ledger_align_at = 60

noremap <buffer> { ?^\d<CR>
noremap <buffer> } /^\d<CR>

nnoremap <buffer> m<CR> :silent make <bar> redraw! <bar> cwindow<CR>
nnoremap <buffer> a<CR> :silent LedgerAlign<CR>

set makeprg=hledger\ -f\ %\ print\ >/dev/null

set foldmethod=syntax
