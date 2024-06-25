#!/usr/bin/env bash
# install.sh - a script to make any shell nice and cozy

# Copyright (C) 2024 JAlexLong
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

VERSION=0.1.4
APT_UTILS="curl git stow tmux htop btop cmatrix neofetch cava remmina nemo nmap ranger wireshark termshark mpv exa zoxide zsh"
FLATPAK_UTILS="spotify"
BINARY_UTILS="tealdeer yt-dlp yt-fzf lobster pfetch brave-browser"
BUILD_UTILS="rustup"
BANNER=""

echo $BANNER
echo '------------------------------------------'
echo 'Welcome to my easy install script! (>^-^)>' 
echo '------------------------------------------'
echo -n 'Install the terminal junkie starter pack? (Y/n): ' 
read confirm 
if [[ $confirm == '' || $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
	# install apt utils
	sudo apt -y update && 
	sudo apt -y upgrade && 
	sudo apt -y install $APT_UTILS
	# install flatpak
	# install flatpak apps
	# download binaries from github
	# download source code from github
	# build binaries from source
fi

# Clone dotfiles from repo
# check if .dotfiles exists
if [[ -d "$HOME/.dotfiles" ]]; then
	echo 'The directory "~/.dotfiles/" already exists.'
	echo 'Would you like to use it anyway?'
	echo "Well, too bad! I haven't developed that feature yet. >.>"
	exit 1
else
	echo -n "Pull dotfiles from GitHub? (y/N): " 
	read confirm
	if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
		cd $HOME
		git clone https://github.com/jalexlong/.dotfiles.git ||
			echo 'Could not pull dotfiles...' &&
			echo 'Please check your internet connection.' &&
			exit 1
	fi
fi

# Stow dotfiles
echo '----------------------------'
echo '      !!! WARNING !!!'
echo '----------------------------'
echo 'Continuing will overwrite any conflicting config files and assumes you are running this'
echo 'on a fresh install of one of the supported operating systems.'
echo
echo '- Debian 12'
echo '- Ubuntu 24.04'
echo '- Pop!_OS'
echo
echo 'This action is PERMANENT and CANNOT BE UNDONE.'
echo -n 'Continue? (y/N): '
read confirm 
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
	echo "Let's get to stowin'"
	stow bash git tmux zsh
fi
