#!/usr/bin/env bash
# pass clip - Password Store Extension (https://www.passwordstore.org/)
# Copyright (C) 2019 Pierre PENNINCKX <ibizapeanut@gmail.com>.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#


PASSWORD_STORE_DIR="${PASSWORD_STORE_DIR:-$HOME/.password-store}"


cmd_clip_usage() {
    cat <<-_EOF
    Usage:
    $PROGRAM clip [options]
        Provide an interactive solution to copy passwords to the
        clipboard. It will show all pass-names in either fzy or rofi,
        waits for the user to select one then copy it to the clipboard.
        The user can select fzy or rofi by giving either --fzy or --rofi.
        By default, rofi will be selected and pass-clip will fallback to
        fzy. If the selected password does not exist, a new one will be
        generated automatically then copied to the clipboard. Specific
        password length can be given using --length and no symbols can
        be activated with --no-symbols. Note the latter two options must
        be given on the command line, one cannot specify them through
        fzy or rofi.

    Options:
        -f, --fzy        Use fzy to select pass-name.
        -r, --rofi       Use rofi to select pass-name.
        -n, --no-symbols Do not use any non-alphanumeric characters.
        -l, --length     Provide a password length.
_EOF
    exit 0
}

cmd_clip_short_usage() {
    echo "Usage: $PROGRAM $COMMAND [--help,-h] [--fzy,-f]|[--rofi,-r] [--no-symbols,-n] [-l <s>,--length <s>]"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1 || exit 1
}

cmd_clip() {
    # Parse arguments
    local opts fzy=0 rofi=0
    local symbols="" length="25"
    local term=""
    opts="$($GETOPT -o s:frnl: -l search-term:,fzy,rofi,no-symbols,length: -n "$PROGRAM $COMMAND" -- "$@")"
    local err=$?
    eval set -- "$opts"

    while true; do case "$1" in
            -f|--fzy) fzy=1; shift ;;
            -r|--rofi) rofi=1; shift ;;
            -n|--no-symbols) symbols="--no-symbols"; shift ;;
            -l|--length) length="$2"; shift 2 ;;
            -s|--search-term) term="$2"; shift 2 ;;
            --) shift; break ;;
    esac done

    if [[ $fzy = 0 && $rofi = 0 ]]; then
        if command_exists fzy; then
            fzy=1
        elif command_exists rofi; then
            rofi=1
        fi
    fi

    [[ $err -ne 0 ]] && die "$(cmd_clip_short_usage)"

    # Figure out if we use fzy or rofi
    local prompt='Copy password into clipboard for 45 seconds '
    local fzy_cmd="fzy --prompt=\"$prompt\""
    local rofi_cmd="rofi -dmenu -i -p \"$prompt\""

    if [ -n "$term" ]; then
      fzy_cmd="$fzy_cmd -q\"$term\""
      rofi_cmd="$rofi_cmd -filter \"$term\""
    fi
    fzy_cmd="$fzy_cmd | tail -n1"

    if [[ $fzy = 1 && $rofi = 1 ]]; then
        die 'Either --fzy,-f or --rofi,-r must be given, not both'
    fi

    if [[ $rofi = 1 || $fzy = 0 ]]; then
        command_exists rofi || die "Could not find rofi in \$PATH"
        menu="$rofi_cmd"
    elif [[ $fzy = 1 || $rofi = 0 ]]; then
        command_exists fzy || die "Could not find fzy in \$PATH"
        menu="$fzy_cmd"
    else
        die "Could not find either fzy or rofi in \$PATH"
    fi

    cd "$PASSWORD_STORE_DIR" || exit 1

    fd='gfind'
    if [ "$(uname)" = 'Linux' ]; then
        fd='find'
    fi

    # Select a passfile
    passfile=$($fd -L "$PASSWORD_STORE_DIR" -path '*/.git' -prune -o -iname '*.gpg' -printf '%P\n' \
        | sed -e 's/.gpg$//' \
        | sort \
        | eval "$menu" )

    if [ -z "$passfile" ]; then
        die 'No passfile selected.'
    fi

    # Either copy existing one or generate a new one
    if ls "$PASSWORD_STORE_DIR/$passfile.gpg" >/dev/null 2>&1; then
        cmd_show "$passfile" --clip || exit 1
    else
        cmd_generate "$passfile" "$length" $symbols --clip || exit 1
    fi
}

[[ "$1" == "help" || "$1" == "--help" || "$1" == "-h" ]] && cmd_clip_usage
cmd_clip "$@"
