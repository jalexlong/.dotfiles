#!/usr/bin/env bash
# base profile: shell, editor, tmux. No graphical config.
set -euo pipefail
. "$(dirname "$(realpath "$0")")/_stow-lib.sh"

require_stow
apply_packages common
"$DOTFILES/scripts/ensure-shell-loaders.sh"

echo
echo "base profile applied (common)"
