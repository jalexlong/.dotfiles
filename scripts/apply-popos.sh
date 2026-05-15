#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

cd "$DOTFILES_DIR"

echo "[*] Applying Pop!_OS dotfiles"
echo "[*] Applying base first"

./scripts/apply-base.sh

if [ -d kitty ]; then
    echo "[*] Applying kitty config"
    stow -v -R kitty
fi

echo "[*] Pop!_OS dotfiles applied"

