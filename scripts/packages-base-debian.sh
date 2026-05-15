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
    htop \
    btop \
    fastfetch \
    ca-certificates
