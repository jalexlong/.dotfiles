#!/usr/bin/env bash
set -euo pipefail

sudo apt update

sudo apt install -y \
    sway \
    waybar \
    swaylock \
    swayidle \
    mako-notifier \
    wofi \
    kitty \
    grim \
    slurp \
    wl-clipboard \
    brightnessctl \
    playerctl \
    fonts-jetbrains-mono \
    fonts-font-awesome \
    fonts-noto-color-emoji \
    network-manager
