func! sessions#MakeSession()
    if !empty(v:this_session)
        execute "mksession! " . fnameescape(v:this_session)
    else
        execute "mksession! " . stdpath('config') . "/sessions/previous.vim"
    endif
endfunc
