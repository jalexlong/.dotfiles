#!/usr/bin/bash
# +---------------------------------------+
# |      JAlexLong's dotfiles installer   |
# +---------------------------------------+
# |This installer is a WIP, but it should |
# |install the desired dotfiles onto your |
# |system in a non-destructive fashion.   |
# |(C) 2025 by JAlexLong under the GPLv3  |
# +---------------------------------------+

_VERSION='0.0.2'
REQUIRED_PACKAGES=("git" "stow" "figlet")

main() {
	check_packages
	display_banner
	install_dotfiles
}

check_packages() {
	missing_pkgs=''
	echo -e "[*] Checking for required packages."
	for pkg in REQUIRED_PKGS; do
		if command -v "$pkg" &> /dev/null; then
			missing_pkgs+="$pkg"
		fi
	done

	if [[ $missing_pkgs = '' ]]; then
		echo "[+] Good to go, boss!"
		return 0
	else
		install_packages $missing_pkgs
		return $?
	fi
}

install_packages() {
	echo "[*] Installing required packages for installer."
	sudo apt install -y $1 &  # Start in background
	wait && return 0
}

display_banner() {
	figlet "JAlexLong's" || return 1  # Attempt to gracefully handle figlet error
	figlet ".dotfiles" || return 1    # Same here
	return 0
}

install_dotfiles() {
	echo -n "[?] Would you like to download and install JAlexLong's dotfiles? (Y/n)> "
	read choice
	case $choice in
		'' ) echo "[*] Downloading dotfiles from GitHub.";;
		[yY]* ) echo "[*] Downloading dotfiles from GitHub.";;
		[nN]* ) return 1;;
		* ) return 2;;
	esac

	# Check if a folder named ".dotfiles" exists in $HOME
	if [[ -d $HOME/.dotfiles ]]; then
		echo "[!] Uh-oh! It looks like you already have a folder named \".dotfiles\""
		echo "    in your home directory. Want me to back them up for you and install"
		echo -n "    my theme? (y/N)> "
		read backup
		case $backup in
			[yY]* ) echo "[*] Backing up dotfiles.";;
			[nN]* ) return 1;;
			* ) return 2;;
		esac
		# Backup old dotfiles
		mv $HOME/.dotfiles $HOME/.backup_dotfiles
		if [[ $? -ne 0 ]]; then
			echo "[!] Could not backup dotfiles. Exiting..."
			return 1
		fi
		echo "[+] Backup successful."
	fi
	# Download dotfiles
	original_dir=$(pwd)
	cd $HOME
	git clone https://github.com/jalexlong/.dotfiles
	cd $HOME/.dotfiles
	echo "[*] Installing dotfiles"
	stow */
	cd $original_dir      # Take it back now, y'all~
	echo "[*] Success!"
	return 0	      # One hop this time~
}

main
