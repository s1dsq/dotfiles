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

# pwd last-executed-command-status shell-privilege
PROMPT='%B%F{#d65d0e}%3~%f%b %(?.%F{green}√.%F{red}?%?)%f %(!.#.>) '

# (git banch) (date - time)
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT="\$vcs_info_msg_0_ (%F{yellow}%D{%d %b %Y}%f - %F{white}%D{%H:%M}%f)"
zstyle ':vcs_info:git:*' formats '%F{cyan}(%b)%f'
zstyle ':vcs_info:*' enable git


# fzf completion
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# tldr completion
[[ -f ~/.tldr.complete ]] && source ~/.tldr.complete
