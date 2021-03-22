source ~/.zsh/plugins_before.zsh

# Initialize completion
autoload -Uz compinit && compinit -i
zstyle ':completion:*' menu select=4
zmodload zsh/complist

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# enable interactive comments
setopt interactivecomments

# Initialize editing command line
autoload -U edit-command-line && zle -N edit-command-line

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt APPEND_HISTORY INC_APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE

# Vim movements
bindkey -v

bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'G' end-of-buffer-or-history

bindkey -a 'u' undo
bindkey -a '^R' redo

bindkey -a '^V' edit-command-line
bindkey "^?" backward-delete-char

source ~/.zsh/prompt.zsh

source ~/.zsh/functions.zsh

source ~/.zsh/alias.zsh

source ~/.zsh/nnn.zsh

source ~/.zsh/fzf.zsh

. $HOME/dotfiles/bin/z

# tldr completion
[[ -f ~/.tldr.complete ]] && source ~/.tldr.complete

source ~/.zsh/plugins_after.zsh

if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi

