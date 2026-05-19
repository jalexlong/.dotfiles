#!/usr/bin/env bash
set -euo pipefail

mkdir -p ~/.local/share/fonts 
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip 
cd ~/.local/share/fonts 
unzip JetBrainsMono.zip 
rm JetBrainsMono.zip 
fc-cache -fv
