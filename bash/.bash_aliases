# +---------------------------------------+
# |      JAlexLong's shortcut stash       |
# |---------------------------------------+

# Welcome to my personal bash aliases!
# (C) 2024-2025 by JAlexLong

# full update for apt, flatpak and more.
function full_system_upgrade() {
    # exit the script if any errors occur
    set -e  

    sudo echo 'Starting full system upgrade.'
    sleep 1

    echo "[+] Updating apt packages."
    sleep 1
    sudo apt -y update && sudo apt -y full-upgrade

    # update flatpaks if flatpak is installed
    if [[ -e /usr/bin/flatpak ]]; then
	    echo "[+] Updating flatpaks."
	    sleep 1
	    flatpak -y update
    else
	    echo "[+] Flatpak not installed. Skipping."
    fi

    if [[ -e /usr/bin/tldr ]]; then
	    echo "[+] Updating tldr/tealdeer caches."
	    sleep 1
	    tldr -u
    fi
}
alias upall=full_system_upgrade

# full bash refresh
function refresh() {
  cd $HOME
  clear
  source ~/.bashrc
}

# quick bash config reload
alias reload="source ~/.bashrc"

# vi/vim -> nvim - use .vimrc instead of nvim config
alias vi="nvim -u ~/.vimrc"
alias vim="nvim -u ~/.vimrc"
alias svim="sudo nvim -u ~/.vimrc"

# WE USE VIM IN THIS HOUSE >:U
alias nano="vim " # !!!

# accidental input of extra vim :q - aka rage quit
alias :q="cowsay -f eyes \"Listen bud, this isn't vim! Get that outta \
  here!! At least have the dang decency to look at the screen before \
  you start quitting out of things...\""
alias :w=":q"
alias :wq=":q"

# directory shortcuts
alias home="cd ~"
alias conf="cd ~/.config"
alias dots="cd ~/.dotfiles"
alias desk="cd ~/Desktop"
alias docs="cd ~/Documents"
alias dldz="cd ~/Downloads"
alias pics="cd ~/Pictures"
alias proj="cd ~/Code"
alias vids="cd ~/Videos"
alias jams="cd ~/Music"

# ls -> eza
alias ls="eza --color=always --group-directories-first --icons "

# ls
alias la="ls -a" # all
alias ll="ls -lh" # long/list view
alias lsa="ls -lah" # ls + la = lsa OR
alias lla="ls -lah" # ll + la = lla
alias lt="ls -aHT --level=3" # tree
alias lst="ls -lahHT --level=3" # lt + ll = lst OR
alias ltl="ls -lahHT --level=3" # lt + ll = ltl

# cp
alias cpd="cp -R"

# mv
alias smv="sudo mv " # we schmoovin'

# rm
alias rmd="rm -r"
alias srm="sudo rm"
alias srmd="sudo rm -r"

# mkdir
alias mkd="mkdir"
alias smkd="sudo mkdir"

# tmux
alias tmls="tmux ls " # trailing space to avoid you-should-use warning
alias tmn="tmux new "
alias tma="tmux attach "

# git - start a working area
alias gcl="git clone "
alias gin="git init "

# git - modify a working area
alias gad="git add "
alias gmv="git mv "
alias grs="git restore "
alias grm="git rm "

# git - examine history and state
alias gdf="git diff "
alias glg="git log "
alias gsh="git show "
alias gst="git status "

# git - grow, mark, tweak your common history
alias gbr="git branch "
alias gcm="git commit "
alias gmr="git merge "
alias grb="git rebase "
alias gsw="git switch "

# git - remote collaboration
alias gfc="git fetch "
alias gpl="git pull "
alias gps="git push "

# clear cache
alias clean="rm -rf ~/.cache/*"

# quick configs
alias valias="vim ~/.bash_aliases"
alias vbash="vim ~/.bashrc"
alias vvim="vim ~/.vimrc"
alias vnvim="vim ~/.config/nvim/"
alias vsway="vim ~/.config/sway/config"
alias vwaybar="vim ~/.config/waybar/"
alias vtmux="vim ~/.tmux.conf"
alias vfetch="vim ~/.config/fastfetch/"

# fastfetch
alias ff="fastfetch "

# networking
alias pingme="ping -c64 github.com"
alias traceme="traceroute github.com"

# clear
alias cls="clear "

# matrix effect
if [[ -e /usr/bin/unimatrix ]]; then
    alias matrix="unimatrix -s 93 -c magenta"
elif [[ -e /usr/bin/cmatrix ]]; then
    alias matrix="cmatrix "
fi

# term-clock -> tock (rust, btw)
if [[ -e /usr/bin/tock ]]; then
    alias clock="tock -mc -C 5"
fi

# python
alias py="python3"

# power
alias sr="sudo reboot"
alias ssn="sudo shutdown now"

# ytfzf
if [[ -e /usr/bin/yt-fzf ]]; then
	alias ytrefresh="ytfzf --refresh-inv-instance"
	alias ytclear="ytfzf --history-clear=search && ytfzf --history-clear=watch"
	alias ytvideo="ytfzf --detach --show-thumbnails --async-thumbnails"
	alias ytaudio="ytfzf --detach --audio-only"
	alias ytmusic="ytfzf --detach --audio-only"
	alias ythistory="ytfzf -H"
fi

# yt-dlp
if [[ -e /usr/bin/yt-dlp ]]; then
	alias ytdlv="yt-dlp -f 'bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]' -N 4 \
	  --keep-video --write-thumbnail --write-subs --write-auto-subs \
	  --embed-subs --embed-thumbnail --embed-metadata --embed-chapters \
	  --embed-info-json --sponsorblock-remove sponsor"
	alias ytdla="yt-dlp --extract-audio --audio-format mp3 --audio-quality 0"
fi
