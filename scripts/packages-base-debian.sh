#!/usr/bin/env bash
set -euo pipefail

sudo apt update

sudo apt install -y \
    git \
    stow \
    curl \
    wget \
    unzip \
    vim \
    neovim \
    tmux \
    btop \
    ca-certificates \
    zoxide

# add required zoxide hook in ~/.bashrc if necessary
if ! grep -q 'eval "$(zoxide init bash)"' "$HOME/.bashrc"; then
    cat >> "$HOME/.bashrc" <<'EOF'
# initialize zoxide hook
eval "$(zoxide init bash)"
EOF
fi
