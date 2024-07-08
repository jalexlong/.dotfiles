# +---------------------------------------+
# |      JAlexLong's shortcut stash       |
# |---------------------------------------+

# Welcome to my personal bash aliases!
# (C) 2024 by JAlexLong

# full system update
alias upall="sudo apt update -y && sudo apt upgrade -y && tldr -u"

# full bash refresh
function bash_refresh() {
  cd $HOME
  clear
  source ~/.bashrc
}
alias refresh=bash_refresh

# quick bash reload
alias reload="source ~/.bashrc"

# vim -> neovim
alias vim="nvim "
alias svim="sudo nvim "

# WE USE NEOVIM IN THIS HOUSE >:U
alias nano="nvim "

# accidental input of extra vim chord ':q' will give glaring eyes
alias :q="cowsay -f eyes \"Listen bud, this isn't vim! Get that outta \
  here!! At least have the dang decency to look at the screen before \
  you start quitting out of things...\""
alias :wq=":q"

# directory shortcuts
alias home="cd ~"
alias conf="cd ~/.config"
alias desk="cd ~/Desktop"
alias docs="cd ~/Documents"
alias dldz="cd ~/Downloads"
alias pics="cd ~/Pictures"
alias proj="cd ~/Code"
alias pub="cd ~/Public"
alias sync="cd ~/Sync"
alias vids="cd ~/Videos"
alias vms="cd ~/Virtual\ Machines"

# cd - wsl edition
#alias cdrive="cd /mnt/c/"
#alias cusers="cd /mnt/c/Users"
#alias progfiles="cd '/mnt/c/Program Files'"

# ls -> exa
alias ls="exa --color=always --group-directories-first --icons"

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
alias mkdir="mkdir -p "
alias md="mkdir"
alias mkd="mkdir"
alias smd="sudo mkdir"
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
alias vbash="nvim ~/.bashrc "
alias valias="nvim ~/.bash_aliases "
alias vnvim="nvim ~/.config/nvim/ "

# networking
alias pingme="ping -c64 github.com"
alias traceme="traceroute github.com"

# clear (with optional system fetch)
alias cls="clear && neofetch"
alias clr="clear "

# journalctl
alias jctl="journalctl -p 3 -xb"

# python
alias py="python3"

# power
alias sr="sudo reboot"
alias ssn="sudo shutdown now"

# brave-browser
alias brave="brave-browser --enable-features=Speedreader:tts/true \
    &>/dev/null &"

