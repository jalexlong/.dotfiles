#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

cd "$DOTFILES_DIR"

echo "[*] Applying Chromebook dotfiles"

./scripts/apply-sway.sh

if [ -d chromebook ]; then
    echo "[*] Applying chromebook overlay"
    stow -v -S -d "$DOTFILES_DIR" -t "$HOME" chromebook
fi

# Enable PipeWire for the current user
systemctl --user --now enable pipewire.service pipewire-pulse.service wireplumber.service

echo "[*] Chromebook dotfiles applied."
