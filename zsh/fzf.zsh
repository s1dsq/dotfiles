fd='fd'
# TODO: fdfind is only for ubuntu
# Try to use a more specific check
if [ "$(uname)" = 'Linux' ]; then
    fd='fdfind'
fi

FD_OPTIONS="--hidden --follow --exclude .git --exclude node_modules"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border=horizontal"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard || $fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="$fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="$fd --type d $FD_OPTIONS"
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
