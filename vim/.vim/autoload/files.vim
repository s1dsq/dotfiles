func! files#SimpleFiles()
    edit! .vim-vsf
    call system("git ls-files --others --exclude-standard --cached > .vim-vsf &")
endfunc

func! files#BufferSettings()
    setl buftype=nofile nobuflisted bufhidden=delete
    map <buffer> <silent> <CR> gf
endfunc

