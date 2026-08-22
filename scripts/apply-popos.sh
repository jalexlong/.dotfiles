#!/usr/bin/env bash
# popos profile: Pop!_OS / COSMIC laptop. base + terminal emulators.
#
# The `cosmic` package folds ~/.config/cosmic/com.system76.CosmicTerm and
# ...Shortcuts into DIRECTORY symlinks, not per-file ones. That is deliberate:
# cosmic-config rewrites a setting by writing a temp file and renaming it over
# the old one, which would replace a per-file symlink with a regular file and
# silently detach it from this repo. With the directory linked instead, the
# rename lands inside the repo and changes made in COSMIC Settings show up as
# ordinary `git diff`.
set -euo pipefail
. "$(dirname "$(realpath "$0")")/_stow-lib.sh"

require_stow
apply_packages common kitty cosmic
"$DOTFILES/scripts/ensure-shell-loaders.sh"

echo
echo "popos profile applied (common kitty cosmic)"
echo
echo "note: making kitty the system x-terminal-emulator needs root and is not"
echo "      done here. run once per machine:"
echo "          sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty"
