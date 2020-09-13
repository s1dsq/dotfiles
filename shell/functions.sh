# mkdir and cd into it
mkcd () {
	mkdir -p "$1"
	cd "$1"
}

# Base16 Gruvbox dark, medium
# Author: Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)

_gen_fzf_default_opts() {

local color00='#282828'
local color01='#3c3836'
local color02='#504945'
local color03='#665c54'
local color04='#bdae93'
local color05='#d5c4a1'
local color06='#ebdbb2'
local color07='#fbf1c7'
local color08='#fb4934'
local color09='#fe8019'
local color0A='#fabd2f'
local color0B='#b8bb26'
local color0C='#8ec07c'
local color0D='#83a598'
local color0E='#d3869b'
local color0F='#d65d0e'

export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border=horizontal"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D"\
" --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"\
" --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

export FZF_DEFAULT_COMMAND="find ."

}

_gen_fzf_default_opts


# No duplicates in path
typeset -U path 
path=()

# Prepend to path
prepath() {
    for dir in "$@"; do 
        # absolute path 
        dir=${dir:A}
        [[ ! -d "$dir" ]] && return
        path=("$dir" $path[@])
    done
}


# Append to path
postpath() {
    for dir in "$@"; do
        dir=${dir:A}
        [[ ! -d "$dir" ]] && return
        path=($path[@] "$dir")
    done
}

prepath /usr/local/opt/llvm/bin /usr/local/sbin /usr/bin /bin /usr/local/bin 
postpath /Library/TeX/texbin


# check if program exists on machine
exists() {
    (( $+commands[$1] ))
}

# If nvim exists set editor and manpager
if exists nvim; then 
    export EDITOR='nvim'
    export MANPAGER="nvim -c 'set ft=man' -"
    alias vim='nvim'
    alias ovim="/usr/bin/vim"
else
    export EDITOR='vim'
    export MANPAGER="vim -c 'set ft=man' -"
fi

