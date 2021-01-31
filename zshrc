# mkdir and cd into it
mkcd () {
	mkdir -p "$1"
	cd "$1" || echo "Can't cd into $1"
}


# Prepend to path
prepath() {
    for dir in "$@"; do 
        # absolute path 
        dir=${dir:A}
        [ ! -d "$dir" ] && return
        path=("$dir" "${path[@]}")
    done
}


# Append to path
postpath() {
    for dir in "$@"; do
        dir=${dir:A}
        [ ! -d "$dir" ] && return
        path=("${path[@]}" "$dir")
    done
}


# cd up $1 directories
up() {
    curdir="$(pwd)"
    if [[ "$1" == ""  ]]; then 
        curdir="$(dirname "$curdir")"
    else
        for ((i=0; i<$1; i++)); do
            local pardir="$(dirname "$curdir")"
            if [[ "$pardir" == "$curdir" ]]; then
                break
            else
                curdir="$pardir"
            fi
        done
    fi
    cd "$curdir" || echo "Can't cd into $1"
}

source ~/.zsh/plugins_before.zsh

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
setopt APPEND_HISTORY INC_APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE

# Vim movements
bindkey -v

bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'G' end-of-buffer-or-history

bindkey -a 'u' undo
bindkey -a '^R' redo

bindkey -a '^V' edit-command-line
bindkey "^?" backward-delete-char

# Commonly used directories
[[ -d $HOME/.config/nvim ]] && hash -d nvim=$HOME/.config/nvim
[[ -d $HOME/.vim/pack/plugins/opt ]] && hash -d plg=$HOME/.vim/pack/plugins/opt
[[ -d $HOME/.vim/pack/colors/start ]] && hash -d col=$HOME/.vim/pack/colors/start

# pwd last-executed-command-status shell-privilege
PROMPT='%B%~%b'$'\n''%(?.%F{green}√.%F{red}?%?)%f %(!.#.>) '

# (git banch)
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT="\$vcs_info_msg_0_"
zstyle ':vcs_info:git:*' formats '%F{cyan}(%b)%f'
zstyle ':vcs_info:*' enable git

# --- CLI programs ---
# fzf completion
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# tldr completion
[[ -f ~/.tldr.complete ]] && source ~/.tldr.complete

# nnn file manager
function n
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

alias n3="nnn -e -d -C -H"
alias nf="n -e -d -C -H"
alias e='vim'
alias cg='cd $(git rev-parse --show-toplevel)'
alias cp='cp -vip'
alias mv='mv -vi'
alias rm='rm -vi'
alias g='git'
alias pass='PASSWORD_STORE_ENABLE_EXTENSIONS=true pass'

source ~/.zsh/plugins_after.zsh

if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi

