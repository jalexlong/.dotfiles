#!/usr/bin/env bash
set -euo pipefail

PROFILE="${1:-popos}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

cd "$DOTFILES_DIR"

case "$PROFILE" in
    base)
        stow -v -R -d "$DOTFILES_DIR" -t "$HOME" common
        ;;

    popos)
        stow -v -R -d "$DOTFILES_DIR" -t "$HOME" common
        stow -v -R -d "$DOTFILES_DIR" -t "$HOME" kitty
        ;;

    sway)
        stow -v -R -d "$DOTFILES_DIR" -t "$HOME" common
        stow -v -R -d "$DOTFILES_DIR" -t "$HOME" kitty
        stow -v -R -d "$DOTFILES_DIR" -t "$HOME" sway
        ;;

    *)
        echo "Unknown profile: $PROFILE"
        echo "Usage: $0 {base|popos|sway}"
        exit 1
        ;;
esac
