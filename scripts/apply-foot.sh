#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

cd "$DOTFILES_DIR"

echo "[*] Applying foot config"

if [ -d foot ]; then
    stow -v -R -d "$DOTFILES_DIR" -t "$HOME" foot
fi

echo "[*] Foot config applied."
