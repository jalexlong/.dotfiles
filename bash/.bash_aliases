# quick bash reload
alias reload="cd ~ && source ~/.bashrc"

# vim
alias svim="sudo vim"

# full system update
alias upall="sudo apt update -y && sudo apt upgrade -y"

# apt
alias install="sudo apt install"
alias search="apt search"
alias uninstall="sudo apt remove"
alias autoremove="sudo apt autoremove"

# power
alias sr="sudo reboot"
alias ssn="sudo shutdown now"

# ls
alias l="ls -lh --color=always --group-directories-first"
alias ls="ls --color=always --group-directories-first"
alias la="ls -a --color=always --group-directories-first"
alias ll="ls -lh --color=always --group-directories-first"
alias lt="ls -aHt --color=always --group-directories-first"
alias lsa="ls -lah --color=always --group-directories-first"

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

# cd - wsl edition
#alias cdrive="cd /mnt/c/"
#alias cusers="cd /mnt/c/Users"
#alias progfiles="cd '/mnt/c/Program Files'"

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

# python
alias py="python3"

# networking
alias pingme="ping -c64 github.com"
alias traceme="traceroute github.com"
