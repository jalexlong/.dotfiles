#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

cd "$DOTFILES_DIR"

echo "[*] Applying Chromebook dotfiles"

./scripts/apply-sway.sh
./scripts/apply-foot.sh

if [ -d chromebook ]; then
    echo "[*] Applying chromebook overlay"
    stow -v -R -d "$DOTFILES_DIR" -t "$HOME" chromebook
fi

# Enable PipeWire for the current user
systemctl --user --now enable pipewire.service pipewire-pulse.service wireplumber.service 2>/dev/null || true

echo "[*] Chromebook dotfiles applied."
