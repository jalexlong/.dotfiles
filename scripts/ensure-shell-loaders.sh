#!/usr/bin/env bash
set -euo pipefail

BASHRC="$HOME/.bashrc"
PROFILE="$HOME/.profile"

touch "$BASHRC"
touch "$PROFILE"

# Debian usually already loads ~/.bash_aliases, but make sure
if ! grep -q '.bash_aliases' "$BASHRC"; then
    cat >> "$BASHRC" <<'BASHRC_EOF'

# Load bash aliases
if [ -f "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi
BASHRC_EOF
fi

# Debian does not usually load ~/.bash_functions, so add that.
if ! grep -q '.bash_functions "$BASHRC"; then
    cat >> "$BASHRC" <<'BASHRC_EOF'

# Load bash functions
if [ -f "$HOME/.bash_functions" ]; then
    . "$HOME/.bash_functions"
fi
BASHRC_EOF
fi

# Load profile snippets from ~/.profile.d
if ! grep -q '.profile.d' "$PROFILE"; then
    cat >> "$PROFILE" <<'PROFILE_EOF'

# Load user profile snippets
if [ -d "$HOME/.profile.d" ]; then
    for file in "$HOME"/.profile.d/*.sh; do
        [ -r "$file" ] && . "$file"
    done
fi
PROFILE_EOF
fi

