# if running bash
if [ -n "$BASH_VERSION" ]; then
    # included .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set EDITOR to nvim/vim/vi respectively
if command -v nvim &> /dev/null; then
    export EDITOR=nvim
    export VISUAL=nvim
elif command -v vim &> /dev/null; then
    export EDITOR=vim
    export VISUAL=vim
elif command -v vi &> /dev/null; then
    export EDITOR=vi
    export VISUAL=vi
fi

# set PATH so it includes user's private bin if it exists
if [[ -f $HOME/bin ]]; then
    export PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [[ -f $HOME/.local/bin ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

