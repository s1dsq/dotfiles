if !exists('g:loaded_fugitive')
    finish
endif

nnoremap <silent> <leader><leader> :Git<CR>
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <space>gg mS:Ggrep!
