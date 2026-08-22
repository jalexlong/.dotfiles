#!/usr/bin/env bash
# Apply a dotfiles profile with GNU Stow.
#
# SCOPE: this installs SYMLINKS ONLY. It deliberately does not install apt
# packages -- package installation moved to paperweight-os (see commit 5f66d62,
# "apt install paperweight-desktop") and is not coming back here.
set -euo pipefail

DOTFILES="$(cd "$(dirname "$(realpath "$0")")" && pwd)"

usage() {
    cat <<'USAGE'
usage: ./install.sh <profile>

profiles:
  base     common
  popos    common kitty cosmic

Applying a profile is idempotent -- re-run it after `git pull` to pick up
newly added packages.
USAGE
}

case "${1:-}" in
    base)  exec "$DOTFILES/scripts/apply-base.sh" ;;
    popos) exec "$DOTFILES/scripts/apply-popos.sh" ;;
    -h|--help|"") usage; exit 0 ;;
    *) echo "error: unknown profile '$1'" >&2; echo >&2; usage >&2; exit 2 ;;
esac
