nnoremap gp :silent %!prettier --stdin-filepath %<CR>

let g:ale_typescript_tslint_config_path = 'tslint.json'
let g:ale_linters_ignore = ['eslint']

nnoremap <leader>a :ALEToggle<CR>
