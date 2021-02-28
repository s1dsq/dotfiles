let g:ledger_align_at = 60
let g:ledger_extra_options = '--pedantic --explicit --check-payees'

noremap <buffer> { ?^\d<CR>
noremap <buffer> } /^\d<CR>

nnoremap <buffer> m<CR> :silent make <bar> redraw! <bar> cwindow<CR>

set foldmethod=syntax
