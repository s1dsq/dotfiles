if !exists('g:nnn#loaded')
  finish
endif

let g:nnn#set_default_mappings = 0
let g:nnn#command = 'nnn -edCH'
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }
nnoremap <silent> - :NnnPicker %:p:h<CR>
