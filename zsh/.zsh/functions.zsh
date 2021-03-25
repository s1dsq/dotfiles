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

# sane defaults for grep
grep() {
  command grep \
    --extended-regexp \
    --binary-files=without-match \
    --line-number \
    --exclude-dir=.git \
    --exclude-dir=node_modules \
    --exclude-dir=dist \
    --color=auto \
    "$@"
    }

# TODO: make this function more general
ls() {
    # (zsh specific) whence: interpret command as expansion if defined as alias
    if whence gls &>/dev/null; then
        command gls -hAl --color=auto --group-directories-first "$@"
    elif [ "$(uname)" = 'Darwin' ]; then
        command ls -hAGl "$@"
    else
        command ls -hAl --color=auto --group-directories-first "$@"
    fi
}

# edit note in EDITOR
noe() {
    $EDITOR $HOME/Nextcloud/Notes/"$@".md
}

# fuzzy select note to edit in EDITOR
# using ripgrep
nof() {
    rg --files --follow $HOME/Nextcloud/Notes | fzy | xargs $EDITOR
}

# quickly open nvim with fugitive status
vg() {
    nvim +Git "+wincmd o"
}
