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
