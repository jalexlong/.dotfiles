#!/usr/bin/env bash
set -euo pipefail

echo "[*] Applying GTK/GSettings dark theme preferences"

if command -v gsettings >/dev/null 2>&1; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' || true
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark' || true
    gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' || true
    gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Classic' || true
    gsettings set org.gnome.desktop.interface cursor-size 20 || true
    gsettings set org.gnome.desktop.interface font-name 'JetBrainsMono Nerd Font 10' || true
else
    echo "[!] gsettings not found; skipping GSettings theme preferences"
fi

