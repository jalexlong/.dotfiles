#!/usr/bin/env bash
set -euo pipefail

sudo apt update

sudo apt install -y \
    btm \
    btop \
    ca-certificates \
    cmatrix \
    cowsay \
    curl \
    eza \
    git \
    lolcat \
    neovim \
    pulseaudio-utils \
    sensible-utils \
    sl \
    stow \
    tmux \
    unzip \
    wget \
    zoxide

# add required zoxide hook in ~/.bashrc if necessary
if ! grep -q 'eval "$(zoxide init bash)"' "$HOME/.bashrc"; then
    cat >> "$HOME/.bashrc" <<'EOF'
# initialize zoxide hook
eval "$(zoxide init bash)"
EOF
fi

