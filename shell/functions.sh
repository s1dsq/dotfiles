# mkdir and cd into it
mkcd () {
	mkdir -p "$1"
	cd "$1"
}


# Prepend to path
prepath() {
    for dir in "$@"; do 
        # absolute path 
        dir=${dir:A}
        [ ! -d "$dir" ] && return
        path=("$dir" $path[@])
    done
}


# Append to path
postpath() {
    for dir in "$@"; do
        dir=${dir:A}
        [ ! -d "$dir" ] && return
        path=($path[@] "$dir")
    done
}


# check if program exists on machine
exists() {
    (( $+commands[$1] ))
}


