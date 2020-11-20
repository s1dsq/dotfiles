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
bindkey "^?" backward-delete-char
# --- SETTINGS ---

# --- EXPORTS ---
# If nvim exists set editor and manpager
export EDITOR='vim'
if exists nvim; then 
    export MANPAGER="nvim -c 'set ft=man nu rnu' -"
fi
alias e='vim'

alias cg='cd $(git rev-parse --show-toplevel)'

# Commonly used directories
[[ -d $HOME/.config/nvim ]] && hash -d nvim=$HOME/.config/nvim
# --- EXPORTS ---

# --- PROMPT ---
# pwd last-executed-command-status shell-privilege
PROMPT='%B%~%b'$'\n''%(?.%F{green}√.%F{red}?%?)%f %(!.#.>) '

# (git banch) (date - time)
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT="\$vcs_info_msg_0_ - (%F{white}%D{%H:%M}%f)"
zstyle ':vcs_info:git:*' formats '%F{cyan}(%b)%f'
zstyle ':vcs_info:*' enable git
# --- PROMPT ---

# --- CLI programs ---
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border=horizontal"
export FZF_DEFAULT_COMMAND="find ."

# fzf completion
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# tldr completion
[[ -f ~/.tldr.complete ]] && source ~/.tldr.complete
# --- CLI programs ---
