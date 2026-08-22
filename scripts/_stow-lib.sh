# shellcheck shell=bash
# Shared helpers for the apply-* scripts. Not executable; source it.

DOTFILES="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/.." && pwd)"

require_stow() {
    if ! command -v stow >/dev/null 2>&1; then
        echo "error: GNU Stow is not installed (apt install stow)" >&2
        exit 1
    fi
}

# apply_packages <pkg>...
# Dry-runs every package first, so a conflict in the last one does not leave the
# first few half-applied. -R (restow) keeps re-runs idempotent and cleans up
# links whose source file was renamed or deleted upstream.
apply_packages() {
    local pkg failed=0 err
    for pkg in "$@"; do
        if [ ! -d "$DOTFILES/$pkg" ]; then
            echo "error: no such stow package: $pkg" >&2
            failed=1
            continue
        fi
        if ! err=$(stow -n -d "$DOTFILES" -t "$HOME" -R "$pkg" 2>&1); then
            echo "conflict in package '$pkg':" >&2
            printf '%s\n' "$err" | sed 's/^/    /' >&2
            failed=1
        fi
    done

    if [ "$failed" -ne 0 ]; then
        echo >&2
        echo "nothing was applied. resolve the conflicts above -- usually a real file" >&2
        echo "sits where a symlink should go, so move it aside first:" >&2
        echo "    mv ~/.tmux.conf ~/.tmux.conf.backup" >&2
        exit 1
    fi

    for pkg in "$@"; do
        echo "applying $pkg"
        stow -d "$DOTFILES" -t "$HOME" -R "$pkg"
    done
}
