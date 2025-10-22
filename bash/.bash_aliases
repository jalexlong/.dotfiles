# +---------------------------------------+
# |      JAlexLong's shortcut stash       |
# |---------------------------------------+

# Welcome to my personal bash aliases!
# (C) 2024-2025 by JAlexLong

# full update for apt/pacman, flatpak and more.
function full_system_upgrade() {
    # exit the function if any errors occur
    set -e  

    sudo echo 'Starting full system upgrade.'
    sleep 1

    # update system packages
    if command -v apt; then
	    echo "[+] Updating apt packages."
	    sleep 1
	    sudo apt -y update && sudo apt -y full-upgrade
    elif command -v pacman; then
	    echo "[+] Updating pacman packages."
	    sleep 1
	    sudo pacman -Syu
    fi

    # update flatpak (if installed)
    if command -v flatpak; then
	    echo "[+] Updating flatpaks."
	    sleep 1
	    flatpak -y update
    else
	    echo "[+] Flatpak not installed. Skipping."
    fi

    if command -v tldr ;then
	    echo "[+] Updating tldr/tealdeer caches."
	    sleep 1
	    tldr --update
    fi
}
alias upall=full_system_upgrade

# quick bash refresh
function refresh() {
  cd $HOME
  clear
  source ~/.bashrc
}

# bash config reload in-place
alias reload="source ~/.bashrc"

# Command upgrades
# ls
if command -v eza &> /dev/null; then
	alias ls="eza --color=auto --group-directories-first --icons "
elif command -v exa &> /dev/null; then
	alias ls="exa --color=auto --group-directories-first "
else
	alias ls="ls --color=always "
fi
# cd
# -- zoxide goes here --

# vi/vim -> nvim - use .vimrc instead of nvim config
alias \
	vi="nvim -u ~/.vimrc" \
	vim="nvim -u ~/.vimrc" \
	svim="sudo nvim -u ~/.vimrc" \
	# WE USE NEOVIM IN THIS HOUSE >:U
	nano="vim " # !!!

# accidental input of extra vim :q - aka rage quit
if command -v cowsay &> /dev/null; then
	alias \
		:q="cowsay -f eyes \"Listen bud, this isn't vim! Get that outta \
	  here!! At least have the dang decency to look at the screen before \
	  you start quitting out of things...\"" \
	  	:qa=":q" \
	  	:w=":q" \
		:wq=":q"
fi

# directory shortcuts
alias \
	home="cd ~" \
	conf="cd ~/.config" \
	dots="cd ~/.dotfiles" \
	desk="cd ~/Desktop" \
	docs="cd ~/Documents" \
	dldz="cd ~/Downloads" \
	pics="cd ~/Pictures" \
	proj="cd ~/Code" \
	vids="cd ~/Videos" \
	jams="cd ~/Music"

# navigation
alias \
	la="ls -a" \
	ll="ls -lh" \
	lsa="ls -lah" \
	lla="ls -lah" \
	lt="ls -aHT --level=3" \
	lst="ls -aHT --level=3" \
	ltl="ls -lahHT --level=3"

# file operations
alias \
	cpd="cp -R" \
	smv="sudo mv " \
	rmd="rm -r" \
	srm="sudo rm" \
	srmd="sudo rm -r" \
	mkd="mkdir" \
	smkd="sudo mkdir" \

# tmux
alias \
	tmls="tmux ls " \
	tmn="tmux new " \
	tma="tmux attach "

# quick configs
alias \
	valias="vim ~/.bash_aliases" \
	vbash="vim ~/.bashrc" \
	vvim="vim ~/.vimrc" \
	vnvim="vim ~/.config/nvim/" \
	vsway="vim ~/.config/sway/config" \
	vwaybar="vim ~/.config/waybar/" \
	vtmux="vim ~/.tmux.conf" \
	vfetch="vim ~/.config/fastfetch/"

# git
alias \
	gcl="git clone " \
	gin="git init " \
	gad="git add " \
	gmv="git mv " \
	grs="git restore " \
	grm="git rm " \
	gdf="git diff " \
	glg="git log " \
	gsh="git show " \
	gst="git status " \
	gbr="git branch " \
	gcm="git commit " \
	gmr="git merge " \
	grb="git rebase " \
	gsw="git switch " \
	gfc="git fetch " \
	gpl="git pull " \
	gps="git push "

# networking
alias \
	pingme="ping -c64 github.com" \
	traceme="traceroute github.com" \
	ip="ip -c" \
	ipa="ip -br -f inet addr" \
	ipl="ip -br link"

# power
alias \
	sr="sudo reboot" \
	ssn="sudo shutdown now"

# python
alias py="python3"

# clear cache
alias clean="rm -rf ~/.cache/*"

# clear screen
alias cls="clear "

# fastfetch
alias ff="fastfetch "

# kitty icat (view images in terminal)
alias icat="kitty +kitten icat"

# ytfzf
if command -v ytfzf &> /dev/null; then
	alias \
		ytrefresh="ytfzf --refresh-inv-instance" \
		ytclear="ytfzf --history-clear=search && ytfzf --history-clear=watch" \
		ytvideo="ytfzf --detach --show-thumbnails --async-thumbnails" \
		ytaudio="ytfzf --detach --audio-only" \
		ytmusic="ytfzf --detach --audio-only" \
		ythistory="ytfzf -H"
fi

# yt-dlp
if command -v yt-dlp &> /dev/null; then
	alias \
		ytdlv="yt-dlp -f 'bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]' -N 4 \
		--keep-video --write-thumbnail --write-subs --write-auto-subs \
		--embed-subs --embed-thumbnail --embed-metadata --embed-chapters \
		--embed-info-json --sponsorblock-remove sponsor" \
		ytdla="yt-dlp --extract-audio --audio-format mp3 --audio-quality 0"
fi

# matrix effect
if command -v unimatrix &> /dev/null; then
    alias matrix="unimatrix -s 93 -c magenta"
elif command -v cmatrix &> /dev/null; then
    alias matrix="cmatrix "
fi

# tty-clock -> tock (rust, btw)
if command -v tock &> /dev/null; then
	alias clock="tock -mc -C 5"
elif command -v tty-clock &> /dev/null; then
	alias clock="tty-clock"
fi

