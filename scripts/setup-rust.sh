#!/usr/bin/env bash
set -euo pipefail

echo "[*] Installing rustup from apt"

sudo apt update
sudo apt install -y rustup

echo "[*] Ensuring profile snippets are loaded"
./scripts/ensure-shell-loaders.sh

echo "[*] Applying base dotfiles so ~/.profile.d/rust.sh exists"
./scripts/apply-base.sh

echo "[*] Loading Rust/Cargo environment for this shell if available"

if [ -f "$HOME/.cargo/env" ]; then
    # shellcheck disable=SC1091
    . "$HOME/.cargo/env"
fi

echo "[*] Installing Rust stable toolchain"

rustup default stable

echo "[*] Rust setup complete"

if command -v rustc >/dev/null 2>&1; then
    rustc --version
else
    echo "[!] rustc not found in current shell. Open a new terminal or run:"
    echo "    source ~/.profile"
fi
