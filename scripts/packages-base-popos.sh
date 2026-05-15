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
    tmux \
    htop \
    btop \
    ca-certificates \
    build-essential

