command! -range GB echo join(systemlist("git -C " . shellescape(expand('%:p:h')) . " blame -L <line1>,<line2> " . expand('%:t')), "\n")
nnoremap gb :<C-u>echo system('git rev-parse --abbrev-ref @ <bar> tr -d "\n"')<CR>
