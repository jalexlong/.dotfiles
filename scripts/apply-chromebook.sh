#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

cd "$DOTFILES_DIR"

echo "[*] Applying Chromebook dotfiles"

./scripts/apply-foot.sh

if [ -d chromebook ]; then
    echo "[*] Applying chromebook overlay"
    stow -v -R -d "$DOTFILES_DIR" -t "$HOME" chromebook
fi

if [ -x ./scripts/apply-gtk-theme.sh ]; then
    ./scripts/apply-gtk-theme.sh
fi

# Enable PipeWire for the current user
if command -v systemctl >/dev/null 2>&1; then
    systemctl --user --now enable pipewire.service pipewire-pulse.service wireplumber.service 2>/dev/null || true
fi

echo "[*] Chromebook dotfiles applied."
