alias n3="nnn -e -d -C -H"
alias nf="n -e -d -C -H"
alias e='$EDITOR'
alias cg='cd $(git rev-parse --show-toplevel)'
alias cp='cp -vip'
alias mv='mv -vi'
alias rm='rm -vi'
alias g='git'
alias p='PASSWORD_STORE_ENABLE_EXTENSIONS=true pass'
alias tis='tig status'
alias hl='hledger'

# Commonly used directories
[[ -d $HOME/.config/nvim ]] && hash -d nvim=$HOME/.config/nvim
[[ -d $HOME/.config/nvim/pack/minpac ]] && hash -d plg=$HOME/.config/nvim/pack/minpac
