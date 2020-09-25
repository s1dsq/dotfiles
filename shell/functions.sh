#!/bin/bash

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


# check if program exists on machine
exists() {
    (( $+commands[$1] ))
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


