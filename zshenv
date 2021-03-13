export DEFAULT_USER=siddharth

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='nvim'
export PAGER='less'
export MANPAGER=$PAGER
export LESS='--ignore-case --hilite-search --LONG-PROMPT --RAW-CONTROL-CHARS --QUIET --no-init --quit-if-one-screen'

# Manpages
export LESS_TERMCAP_md=$'\e[32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[100;37m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[34m'

path=($path $HOME/dotfiles/bin/)

# No duplicates in path
typeset -U path
