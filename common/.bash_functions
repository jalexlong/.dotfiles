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

