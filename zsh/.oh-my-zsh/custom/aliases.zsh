# quick zsh reload
alias reload="cd ~ && source ~/.zshrc"

# vim
alias svim="sudo vim"

# full system update

# apt
alias upall="sudo apt update -y && sudo apt upgrade -y; flatpak update -y"
alias install="sudo apt install"
alias search="apt search"
alias uninstall="sudo apt remove"
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

# exa
alias l="exa -lh --color=always --group-directories-first --icons"
alias ls="exa --color=always --group-directories-first --icons"
alias la="exa -a --color=always --group-directories-first --icons"
alias ll="exa -lh --color=always --group-directories-first --icons"
alias lt="exa -aHt --color=always --group-directories-first --icons"
alias lsa="exa -lah --color=always --group-directories-first --icons"

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
alias srm="sudo rm"
alias srmd="sudo rm -r"

# mkdir
alias md="mkdir -p"
alias smd="sudo mkdir -p"

# brave
alias brave="brave-browser"

# python
alias py="python3"

# yt-dlp
alias ytv="yt-dlp -f 'bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]' -N 4"
alias yta="yt-dlp --extract-audio --audio-format mp3"

# journalctl
alias jctl="journalctl -p 3 -xb"

# networking
alias pping="prettyping"
alias pingme="ping -c64 github.com"
alias traceme="traceroute github.com"

# eye candy
alias cls="clear && pfetch"
alias matrix="unimatrix -s 93 -c magenta"
