#!/usr/bin/env bash
set -euo pipefail

echo "[*] Installing rustup from apt"

sudo apt update
sudo apt install -y rustup

echo "[*] Ensuring shell/profile loaders exist"
./scripts/ensure-shell-loaders.sh

echo "[*] Applying base dotfiles"
./scripts/apply-base.sh

echo "[*] Loading Rust/Cargo PATH for this shell"

export CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$HOME/.rustup}"

case ":$PATH:" in
    *":$CARGO_HOME/bin:"*) ;;
    *) export PATH="$CARGO_HOME/bin:$PATH" ;;
esac

echo "[*] Installing Rust stable toolchain"
rustup default stable

echo "[*] Rust setup result"
echo "CARGO_HOME=$CARGO_HOME"
echo "RUSTUP_HOME=$RUSTUP_HOME"
echo "PATH contains Cargo bin:"
case ":$PATH:" in
    *":$CARGO_HOME/bin:"*) echo "yes: $CARGO_HOME/bin" ;;
    *) echo "no" ;;
esac

echo
command -v rustup || true
command -v rustc || true
command -v cargo || true

echo
rustup show || true
rustc --version || true
cargo --version || true
