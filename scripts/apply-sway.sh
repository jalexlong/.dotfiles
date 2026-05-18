#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

cd "$DOTFILES_DIR"

echo "[*] Applying Sway dotfiles"
echo "[*] Applying base first"

./scripts/apply-base.sh

if [ -d sway ]; then
    echo "[*] Applying sway config"
    stow -v -R sway
fi

echo "[*] Sway dotfiles applied"
