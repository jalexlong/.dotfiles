#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

cd "$DOTFILES_DIR"

echo "[*] Applying base dotfiles"
echo "[*] Base means: common shell/editor/tmux/profile config only"

stow -v -R common

echo "[*] Base dotfiles applied."

