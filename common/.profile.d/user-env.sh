# Sourced by ~/.profile via the ~/.profile.d/*.sh loop. Runs under /bin/sh on
# login, so POSIX only -- no bashisms.

# NOTE: this file deliberately does NOT source ~/.bashrc. The stock ~/.profile
# already does that at the top, before it reaches the .profile.d loop, so a copy
# here sourced it a second time on every login -- which is half of why PATH kept
# accumulating duplicates (~/.bashrc appends to PATH too).

# prepend to PATH only when not already present. Re-sourcing ~/.profile must be
# idempotent: the `reload` alias does exactly that, so an unguarded
# PATH="$dir:$PATH" stacks another copy every single time it is run.
path_prepend() {
    case ":${PATH}:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}

# set EDITOR to nvim/vim/vi respectively
if command -v nvim > /dev/null 2>&1; then
    export EDITOR=nvim
    export VISUAL=nvim
elif command -v vim > /dev/null 2>&1; then
    export EDITOR=vim
    export VISUAL=vim
elif command -v vi > /dev/null 2>&1; then
    export EDITOR=vi
    export VISUAL=vi
fi

# collapse duplicate PATH entries, keeping the first occurrence of each.
#
# Guarding our own additions is not sufficient. The stock ~/.profile prepends
# ~/.local/bin at the top with no guard of its own, before it reaches the
# .profile.d loop -- so every re-source (`reload` runs `source ~/.profile`) adds
# another copy before this file gets a say. ~/.profile is distro-owned and left
# unpatched so its updates keep flowing, which means the cleanup belongs here.
path_dedupe() {
    _pd_new=''
    _pd_ifs=$IFS
    IFS=:
    for _pd_dir in $PATH; do
        [ -n "$_pd_dir" ] || continue
        case ":$_pd_new:" in
            *":$_pd_dir:"*) ;;
            *) _pd_new="${_pd_new:+$_pd_new:}$_pd_dir" ;;
        esac
    done
    IFS=$_pd_ifs
    PATH=$_pd_new
    unset _pd_new _pd_ifs _pd_dir
}

# user's private bin directories
[ -d "$HOME/bin" ] && path_prepend "$HOME/bin"
[ -d "$HOME/.local/bin" ] && path_prepend "$HOME/.local/bin"

path_dedupe
export PATH

unset -f path_prepend path_dedupe
