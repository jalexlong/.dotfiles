# Bash functions

# full update for apt/pacman, flatpak and more.
function upall() {
    sudo -v
    echo "[+] Starting full system upgrade."
    sleep 1

    # update system packages
    if command -v apt &> /dev/null; then
	    echo "[+] Updating apt packages."
	    sleep 1
	    sudo apt -y update && sudo apt -y full-upgrade && sudo apt autoremove
    elif command -v pacman &> /dev/null; then
	    echo "[+] Updating pacman packages."
	    sleep 1
	    sudo pacman -Syu
    fi

    # update flatpak (if installed)
    if command -v flatpak &> /dev/null; then
	    echo "[+] Updating flatpaks."
	    sleep 1
	    flatpak -y update
    fi

    # update tldr/tealdeer
    if command -v tldr &> /dev/null; then
        echo "[+] Updating tldr/tealdeer caches."
        sleep 1
        local timeout_msg="[#] WARN: tldr update is taking too long. Skipping..."
        timeout --kill-after 30s 10s tldr --update || echo "$timeout_msg"
    fi

    echo "[+] System upgrade complete!"
}

# quick bash refresh
function refresh() {
    cd "$HOME" || return 1
    clear
    # shellcheck source=/dev/null
    source ~/.bashrc
}

# mkdir <dir> + cd <dir>
function mkcd() {
    if [ $# -lt 1 ]; then
        echo "usage: mkcd <dir>"
        return 1
    fi
    mkdir -p "$1" && cd "$1" || return 1
}

# extract any standard archive filetype
function extract() {
    if [ $# -lt 1 ]; then
        echo "usage: extract <archive>"
        return 1
    fi

    if [ ! -f "$1" ]; then
        echo "extract: not a file: $1"
        return 1
    fi

    case "$1" in
        *.tar.bz2)  tar xjf "$1" ;;
        *.tar.gz)   tar xzf "$1" ;;
        *.bz2)      bunzip2 "$1" ;;
        *.rar)      unrar x "$1" ;;
        *.gz)       gunzip "$1" ;;
        *.tar)      tar xf "$1" ;;
        *.tbz2)     tar xjf "$1" ;;
        *.tgz)      tar xzf "$1" ;;
        *.zip)      unzip "$1" ;;
        *.7z)       7z x "$1" ;;
        *)          echo "extract: unknown archive type: $1"; return 1 ;;
    esac
}

# detect and activate python virtual environment
function activate() {
    # shellcheck source=/dev/null
    if [ -d .venv ]; then
        source .venv/bin/activate
    elif [ -d venv ]; then
        # shellcheck source=/dev/null
        source venv/bin/activate
    else
        echo "No virtual environment detected."
    fi
}


# list the layout names tlayout knows, one per line
function _tlayout_names() {
    local f
    for f in "${XDG_CONFIG_HOME:-$HOME/.config}"/tmux/layouts/*.tmux; do
        [ -e "$f" ] || continue
        f=${f##*/}
        echo "${f%.tmux}"
    done
}

# open a saved tmux layout from ~/.config/tmux/layouts/<name>.tmux: a new window
# inside tmux, a new session outside it. With no name, list the layouts.
function tlayout() {
    if [ -z "$1" ]; then
        _tlayout_names
        return
    fi
    local file="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/layouts/$1.tmux"
    if [ ! -f "$file" ]; then
        echo "tlayout: no such layout: $1" >&2
        return 1
    fi
    if [ -n "$TMUX" ]; then
        tmux new-window -n "$1" \; source-file "$file"
    else
        tmux new-session -s "$1" \; source-file "$file"
    fi
}
function _tlayout_complete() {
    mapfile -t COMPREPLY < <(compgen -W "$(_tlayout_names)" -- "${COMP_WORDS[COMP_CWORD]}")
}
complete -F _tlayout_complete tlayout
