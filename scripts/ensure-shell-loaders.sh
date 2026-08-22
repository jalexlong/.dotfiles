#!/usr/bin/env bash
# Idempotently make the DISTRO-OWNED shell startup files load the bits this repo
# manages, and repair the one line in them known to corrupt PATH. We patch
# rather than replace: ~/.bashrc and ~/.profile stay owned by Debian/Pop!_OS so
# distro updates to them keep flowing.
#
#   ~/.bashrc   -> ~/.bash_aliases, ~/.bash_functions
#   ~/.profile  -> ~/.profile.d/*.sh
#   ~/.bashrc   -> guard the cargo PATH prepend (see ensure_cargo_guard)
# The loader blocks below are single-quoted on purpose: they are written
# verbatim INTO ~/.bashrc and ~/.profile, so $HOME has to survive as literal
# text rather than expanding to this machine's home directory at patch time.
# shellcheck disable=SC2016

set -euo pipefail

CARGO_MARKER='# dotfiles: guarded so re-sourcing cannot stack PATH copies'

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

# ~/.bashrc ships an unguarded PATH prepend for Cargo:
#
#     [ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"
#
# ~/.bashrc is sourced more than once per login -- ~/.profile sources it, and
# the `reload` alias sources ~/.profile and ~/.bashrc back to back -- so that
# line adds another copy of the same directory every time. Wrap it in a
# membership test. Rewritten in place rather than appended, because the
# duplicate has already been added by the time any appended block would run.
#
# common/.profile.d/user-env.sh has path_dedupe, which cleans this up for LOGIN
# shells. This covers non-login shells, which never read ~/.profile at all.
ensure_cargo_guard() {
    local file="$HOME/.bashrc" tmp
    if [ ! -f "$file" ]; then
        echo "  skip    $file does not exist"
        return
    fi
    if grep -qF "$CARGO_MARKER" "$file"; then
        echo "  ok      $file cargo PATH prepend already guarded"
        return
    fi
    if ! grep -q '\.cargo/bin' "$file" || ! grep -q 'PATH=' "$file"; then
        echo "  skip    $file has no cargo PATH prepend"
        return
    fi

    tmp="$(mktemp)"
    awk -v marker="$CARGO_MARKER" '
        !patched && $0 !~ /^[[:space:]]*#/ &&
        index($0, ".cargo/bin") && index($0, "PATH=") {
            print marker
            print "case \":$PATH:\" in"
            print "    *\":$HOME/.cargo/bin:\"*) ;;"
            print "    *) [ -d \"$HOME/.cargo/bin\" ] && export PATH=\"$HOME/.cargo/bin:$PATH\" ;;"
            print "esac"
            patched = 1
            next
        }
        { print }
    ' "$file" > "$tmp"

    # never install a ~/.bashrc that will not parse
    if ! bash -n "$tmp" 2>/dev/null; then
        rm -f "$tmp"
        echo "  ERROR   refusing to patch $file: result failed bash -n" >&2
        return 1
    fi
    if ! grep -qF "$CARGO_MARKER" "$tmp"; then
        rm -f "$tmp"
        echo "  skip    $file cargo line did not match, left alone"
        return
    fi

    cp -a "$file" "$file.dotfiles-backup"
    cat "$tmp" > "$file"
    rm -f "$tmp"
    echo "  patched $file cargo PATH prepend now guarded (backup: $file.dotfiles-backup)"
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

ensure_cargo_guard
