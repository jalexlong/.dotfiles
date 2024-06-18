# quick zsh reload
alias reload="cd ~ && source ~/.zshrc"

# vim
alias svim="sudo vim"

# tmux
alias tmls="tmux ls"
alias tmn="tmux new"
alias tma="tmux attach"

# full system update
update_all () {
	sudo apt -y update && sudo apt -y upgrade
	flatpak -y update
	omz update
	rustup update
	tldr -u
	yt-dlp -U
	lobster -u
}
alias upall=update_all

# apt
alias autoremove="sudo apt autoremove"

# config
alias vzsh="vim ~/.zshrc"
alias valias="vim ~/.oh-my-zsh/custom/aliases.zsh"
alias vvim="vim ~/.vimrc"
alias vmakepkg="sudo vim /etc/makepkg.conf"
alias vgrub="sudo vim /etc/default/grub"

# power
alias sr="sudo reboot"
alias ssn="sudo shutdown now"

# cat -> bat
alias cat="bat"

# ls -> exa
alias ls="exa --color=always --group-directories-first --icons"

# ls
alias la="ls -a"
alias ll="ls -lh"
alias lt="ls -aHT"
alias lsa="ls -lah" # nice ls + la OR
alias lla="ls -lah" # ll + la
alias lst="ls -lahHT" # nice lt + ll OR
alias ltl="ls -lahHT" # lt + ll

# cd
alias home="cd ~"
alias conf="cd ~/.config"
alias desk="cd ~/Desktop"
alias docs="cd ~/Documents"
alias dldz="cd ~/Downloads"
alias pics="cd ~/Pictures"
alias proj="cd ~/Code"
alias pub="cd ~/Public"
alias vids="cd ~/Videos"

# cp
alias cpd="cp -R"
alias scpd="sudo cp -R"

# mv
alias smv="sudo mv"

# rm
alias rmd="rm -r"
alias rmdir="rm -r"
alias srm="sudo rm"
alias srmd="sudo rm -r"
alias srmdir="sudo rm -r"

# mkdir
alias md="mkdir -p"
alias mkd="mkdir -p"
alias smd="sudo mkdir -p"
alias smkd="sudo mkdir -p"
alias mkdir="mkdir -p" # friendly default, keep at end of this section

# python
alias py="python3"

# yt-dlp
alias ytv="yt-dlp -f 'bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]' -N 4"
alias yta="yt-dlp --extract-audio --audio-format mp3"

# ytfzf
alias ytreload="ytfzf --refresh-inv-instance"
alias ytclear="ytfzf --history-clear=search && ytfzf --history-clear=watch"
alias ytsearch="ytfzf --detach --show-thumbnails --async-thumbnails"
alias ytaudio="ytfzf --detach --audio-only"
alias ythistory="ytfzf -H"

# journalctl
alias jctl="journalctl -p 3 -xb"

# networking
alias pping="prettyping"
alias pingme="ping -c64 github.com"
alias traceme="traceroute github.com"

# clear (optional fetch)
alias clr="clear " # whitespace to hide "you-should-use" warning on clear
alias cls="clear && pfetch"
alias ncls="clear && neofetch"
alias matrix="unimatrix -s 93 -c magenta"
alias clock="tock -mc -C 5"
