#!/usr/bin/env bash
set -euo pipefail

PROFILE="${1:-base}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

cd "$DOTFILES_DIR"

echo "[*] Installing dotfiles profile: $PROFILE"

case "$PROFILE" in
    base)
        ./scripts/packages-base-debian.sh
        ./scripts/ensure-shell-loaders.sh
        ./scripts/apply-base.sh
        ;;
    popos)
        if [ -x ./scripts/packages-base-popos.sh ]; then
            ./scripts/packages-base-popos.sh
        else
            ./scripts/packages-base-debian.sh
        fi

        if [ -x ./scripts/packages-kitty-debian.sh ]; then
            ./scripts/packages-kitty-debian.sh
        fi

        ./scripts/ensure-shell-loaders.sh
        ./scripts/apply-popos.sh
        ;;

    sway)
        ./scripts/packages-base-debian.sh

        if [ -x ./scripts/packages-kitty-debian.sh ]; then
            ./scripts/packages-kitty-debian.sh
        fi

        ./scripts/packages-sway-debian.sh
        ./scripts/ensure-shell-loaders.sh
        ./scripts/apply-sway.sh
        ;;

    ctf)
        ./scripts/packages-base-debian.sh
        ./scripts/packages-ctf-debian.sh
        ./scripts/ensure-shell-loaders.sh
        ./scripts/apply-base.sh
        ;;

    chromebook)
        ./scripts/packages-base-debian.sh
        ./scripts/packages-kitty-debian.sh
        ./scripts/packages-sway-debian.sh
        ./scripts/ensure-shell-loaders.sh
        ./scripts/apply-chromebook.sh
        ;;

    rust)
        ./scripts/setup-rust.sh
        ;;

    *)
        echo "Unknown profile: $PROFILE"
        echo "Usage: ./install.sh {base|popos|sway|chromebook|ctf|rust}"
        exit 1
        ;;
esac

echo "[*] Done."
echo
echo "Open a new shell, or run:"
echo "  source ~/.profile"
echo "  source ~/.bashrc"

