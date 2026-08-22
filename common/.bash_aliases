# +---------------------------------------+
# |      JAlexLong's shortcut stash       |
# |---------------------------------------+

# Welcome to my personal bash aliases!
# (C) 2024-2026 by JAlexLong

# include optional aliases
#
# `source dir/*` does NOT source every match: source takes ONE file and treats
# any remaining words as positional parameters ($1, $2, ...) for it. So only the
# first file was ever loaded, and the rest silently became arguments to it. On an
# empty directory the glob stays literal and source errors on startup instead.
if [ -d ~/.local/aliases ]; then
    for _alias_file in ~/.local/aliases/*; do
        [ -r "$_alias_file" ] && . "$_alias_file"
    done
    unset _alias_file
fi

# bash config reload in-place
alias reload="source ~/.profile && source ~/.bashrc"

# print PATH nicely
alias path='echo "$PATH" | tr ":" "\n"'

# query command paths and aliases
alias cv="command -v"

# Command upgrades
# ls
#
# The tree aliases (lt/lst/ltl) live inside each branch on purpose. -T and
# --level are eza/exa flags; GNU ls has neither, and `ls -aHT --level=3` there
# fails outright with "invalid tab size". Defining them once outside the
# conditional silently broke them on any machine without eza installed.
if command -v eza &> /dev/null; then
	alias ls="eza --color=auto --group-directories-first --icons "
	alias \
		lt="eza -aHT --level=3" \
		lst="eza -aHT --level=3" \
		ltl="eza -lahHT --level=3"
elif command -v exa &> /dev/null; then
	alias ls="exa --color=auto --group-directories-first "
	alias \
		lt="exa -aHT --level=3" \
		lst="exa -aHT --level=3" \
		ltl="exa -lahHT --level=3"
else
	# --color=auto, never =always: `always` emits escape codes even when stdout
	# is a pipe, so `ls | grep '^name$'` stops matching.
	alias ls="ls --color=auto "
	if command -v tree &> /dev/null; then
		alias \
			lt="tree -a -L 3" \
			lst="tree -a -L 3" \
			ltl="tree -a -L 3 -p -h"
	fi
fi

# vi/vim -> nvim - use .vimrc instead of nvim config
if command -v nvim &> /dev/null; then
    alias \
        vi="nvim " \
        vim="nvim " \
        svim="sudo nvim "
elif command -v vim &> /dev/null; then
    alias \
        vi="vim " \
        svim="sudo vim "
fi

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

# navigation (tree variants are defined with the ls alias above)
alias \
	la="ls -a" \
	ll="ls -lh" \
	lsa="ls -lah" \
	lla="ls -lah"

# file operations
alias \
	cpd="cp -R" \
	smv="sudo mv " \
	rmd="rm -r" \
	srm="sudo rm" \
	srmd="sudo rm -r" \
	mkd="mkdir -p" \
	smkd="sudo mkdir -p"

# tmux
alias \
	tmls="tmux ls " \
	tmn="tmux new " \
	tma="tmux attach "

# quick configs
alias \
	vbash="vim ~/.bashrc" \
	valias="vim ~/.bash_aliases" \
    vfunc="vim ~/.bash_functions" \
    vprofile="vim ~/.profile" \
	vvim="vim ~/.vimrc" \
	vnvim="vim ~/.config/nvim/init.vim" \
	vtmux="vim ~/.tmux.conf" \
    vssh="vim ~/.ssh/"

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
	pingme="ping -c64 google.com" \
	traceme="traceroute google.com" \
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


# +---------------------------------------+
# |            prompt colors              |
# +---------------------------------------+
# Ubuntu's stock ~/.bashrc gates the color prompt on a TERM *name* whitelist:
#     case "$TERM" in xterm-color|*-256color) color_prompt=yes;; esac
# cosmic-term sets TERM=xterm-256color, which matches. kitty sets
# TERM=xterm-kitty, which matches neither pattern, so the prompt silently falls
# back to the plain white branch. (Inside tmux TERM=tmux-256color, which does
# match, so kitty only loses the color OUTSIDE tmux.)
#
# ~/.bashrc is distro-owned and untracked, so rather than patch it, decide on
# actual capability here instead of on the terminal's name. This file is
# sourced by ~/.bashrc after PS1 is set, so it wins.
if [ -x /usr/bin/tput ] && tput setaf 1 >/dev/null 2>&1; then
    # bold green user@host, bold blue path. for an all-green prompt, change
    # the 01;34 below to 01;32.
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

    # ~/.bashrc adds the "user@host: dir" window title for TERM=xterm*, but it
    # does that BEFORE this file runs, so redefining PS1 above dropped it.
    # xterm-kitty matches xterm*, so put it back.
    case "$TERM" in
        xterm*|rxvt*)
            PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
            ;;
    esac
fi
