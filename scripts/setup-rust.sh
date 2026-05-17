#!/usr/bin/env bash
set -euo pipefail

echo "[*] Installing rustup from apt"

sudo apt update
sudo apt install -y rustup

echo "[*] Ensuring shell/profile loaders are present"
./scripts/ensure-shell-loaders.sh

echo "[*] Applying base dotfiles"
./scripts/apply-base.sh

echo "[*] Ensuring Cargo bin directory exists"
mkdir -p "$HOME/.cargo/bin"

echo "[*] Loading Cargo PATH for this installer shell"
case ":$PATH:" in
    *":$HOME/.cargo/bin:"*) ;;
    *) export PATH="$HOME/.cargo/bin:$PATH" ;;
esac

echo "[*] Installing Rust stable toolchain"
rustup default stable

echo "[*] Rust setup complete"

echo "[*] Tool versions:"
command -v rustup >/dev/null 2>&1 && rustup --version || true
command -v rustc >/dev/null 2>&1 && rustc --version || true
command -v cargo >/dev/null 2>&1 && cargo --version || true

echo
echo "Open a new terminal, or run:"
echo "  source ~/.profile"

