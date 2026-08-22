#!/usr/bin/env bash
# Idempotently make the DISTRO-OWNED shell startup files load the bits this repo
# manages. We patch rather than replace: ~/.bashrc and ~/.profile stay owned by
# Debian/Pop!_OS so distro updates to them keep flowing.
#
#   ~/.bashrc   -> ~/.bash_aliases, ~/.bash_functions
#   ~/.profile  -> ~/.profile.d/*.sh
set -euo pipefail

ensure_block() {
    local file="$1" marker="$2" block="$3"
    [ -f "$file" ] || touch "$file"
    if grep -qF "$marker" "$file"; then
        echo "  ok      $file already loads $marker"
        return
    fi
    printf '\n%s\n' "$block" >> "$file"
    echo "  patched $file now loads $marker"
}

echo "checking shell loaders"

ensure_block "$HOME/.bashrc" '.bash_aliases' \
'if [ -f "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi'

ensure_block "$HOME/.bashrc" '.bash_functions' \
'if [ -f "$HOME/.bash_functions" ]; then
    . "$HOME/.bash_functions"
fi'

ensure_block "$HOME/.profile" '.profile.d' \
'if [ -d "$HOME/.profile.d" ]; then
    for file in "$HOME"/.profile.d/*.sh; do
        [ -r "$file" ] && . "$file"
    done
fi'
