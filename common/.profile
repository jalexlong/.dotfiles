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

if [[ -f $HOME/bin ]]; then
    export PATH="$HOME/bin:$PATH"
fi

if [[ -f $HOME/.local/bin ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

