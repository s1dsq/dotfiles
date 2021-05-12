if !exists(':Telescope')
  finish
endif

nnoremap ,f <cmd>lua require('telescope.builtin').find_files({previewer=false, hidden=true})<cr>
nnoremap ,g <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap g<CR> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap ,h <cmd>lua require('telescope.builtin').help_tags()<cr>
