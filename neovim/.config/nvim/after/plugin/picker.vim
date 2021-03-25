if !exists('g:loaded_picker')
    finish
endif

let g:picker_height = 15

" Add custom picker split commands.
command! -bar PickerBufferVsplit vsplit | PickerBuffer

" Add vim picker mappings.
nmap <unique> ,f <Plug>(PickerEdit)
nmap <unique> ,v <Plug>(PickerVsplit)
nmap <unique> ,h <Plug>(PickerHelp)
nmap <unique> g<CR> <Plug>(PickerBuffer)
" nmap does not work for some reason
nnoremap <unique> g\ :PickerBufferVsplit<CR>

" vim:fdm=marker ft=vim et sts=2 sw=2
