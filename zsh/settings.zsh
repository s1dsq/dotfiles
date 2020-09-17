# --- SETTINGS ---
# No duplicates in path
typeset -U path 

# Initialize completion
autoload -Uz compinit && compinit -i
zstyle ':completion:*' menu select=4
zmodload zsh/complist

# enable interactive comments
setopt interactivecomments

# Initialize editing command line
autoload -U edit-command-line && zle -N edit-command-line

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt incappendhistory
setopt sharehistory

# Vim movements
bindkey -v

bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'G' end-of-buffer-or-history

bindkey -a 'u' undo
bindkey -a '^R' redo

bindkey -a '^V' edit-command-line
# --- SETTINGS ---

# --- EXPORTS ---
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
alias e='vim'

# Commonly used directories
[[ -d $HOME/.config/nvim ]] && hash -d nvim=$HOME/.config/nvim
# --- EXPORTS ---

# --- PROMPT ---
# pwd last-executed-command-status shell-privilege
local gray='#a89984'
local orange='#fe8019'
PROMPT='%B%3~%b %(?.%F{green}√.%F{red}?%?)%f %(!.#.>) '

# (git banch) (date - time)
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT="\$vcs_info_msg_0_ (%F{yellow}%D{%d %b %Y}%f - %F{white}%D{%H:%M}%f)"
zstyle ':vcs_info:git:*' formats '%F{cyan}(%b)%f'
zstyle ':vcs_info:*' enable git
# --- PROMPT ---

# --- CLI programs ---
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

# fzf completion
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# tldr completion
[[ -f ~/.tldr.complete ]] && source ~/.tldr.complete
# --- CLI programs ---
