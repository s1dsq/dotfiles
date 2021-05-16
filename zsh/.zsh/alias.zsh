alias e='$EDITOR'

# cd to git root
alias cg='cd $(git rev-parse --show-toplevel)'

# cp, mv, rm verbose and with confirmation
alias cp='cp -vip'
alias mv='mv -vi'
alias rm='rm -vi'

alias g='git'

# enable extension scripts for pass
alias p='PASSWORD_STORE_ENABLE_EXTENSIONS=true pass'

alias tis='tig status'

alias hl='hledger'

# Commonly used directories
[[ -d $HOME/.config/nvim ]] && hash -d nvim=$HOME/.config/nvim
[[ -d $HOME/.config/nvim/pack/minpac ]] && hash -d plg=$HOME/.config/nvim/pack/minpac
