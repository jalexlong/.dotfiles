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
if ! grep -q 'eval "$(zoxide init bash)"' "~/.bashrc"; then
    echo 'eval "$(zoxide init bash)"' >> "~/.bashrc"
fi
