# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zsh/plugins_before.zsh

# Initialize completion
autoload -Uz compinit && compinit -i
zstyle ':completion:*' menu select=4
zmodload zsh/complist

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# enable interactive comments
setopt interactivecomments

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt APPEND_HISTORY INC_APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE

# Load functions in $fpath
# ls + arrow keys shows commands beginning with ls
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

autoload -Uz edit-command-line
zle -N edit-command-line

# run-help opens man pages for commands
unalias run-help
autoload -Uz run-help run-help-git

# Vi mode
bindkey -v
bindkey -M vicmd 'u' undo
bindkey -M vicmd '^R' redo
bindkey -M vicmd '^V' edit-command-line
bindkey -M viins '^p' up-line-or-history
bindkey -M viins '^n' down-line-or-history
bindkey '^k'  run-help
bindkey "^?" backward-delete-char
bindkey '^[[A'  up-line-or-beginning-search    # Arrow up
bindkey '^[OA'  up-line-or-beginning-search
bindkey '^[[B'  down-line-or-beginning-search  # Arrow down
bindkey '^[OB'  down-line-or-beginning-search

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

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
