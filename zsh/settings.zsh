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
RPROMPT="\$vcs_info_msg_0_"
zstyle ':vcs_info:git:*' formats '%F{cyan}(%b)%f'
zstyle ':vcs_info:*' enable git
# --- PROMPT ---

# --- CLI programs ---
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border=horizontal"
export FZF_DEFAULT_COMMAND="find ."
_gen_fzf_default_opts() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"

  # Comment and uncomment below for the light theme.

  # Solarized Dark color scheme for fzf
  # export FZF_DEFAULT_OPTS="
  #   --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
  #   --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
  # "
  # Solarized Light color scheme for fzf
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS""
    --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
  "
}

_gen_fzf_default_opts

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
# --- CLI programs ---
