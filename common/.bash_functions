# Bash functions

# full update for apt/pacman, flatpak and more.
function upall() {
    sudo echo "Starting full system upgrade."
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
        tldr --update
    fi

    echo "[+] System upgrade complete!"
}

# quick bash refresh
function refresh() {
  cd $HOME
  clear
  source ~/.bashrc
}

# mkdir <dir> + cd <dir>
function mkcd() {
    mkdir -p "$1" && cd "$1"
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
        *)          echo "extract: unknown archive type: $1"; return1 ;;
    esac
}

