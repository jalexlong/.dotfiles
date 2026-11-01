# Node.js / npm environment
#
# The system nodejs package (apt) is pinned to Node 20, and there's no
# passwordless sudo to upgrade it in place. A standalone Node 22 build was
# installed to ~/.local/node22 (curl tarball from nodejs.org, no npm/nvm
# needed) so modern tooling that requires Node >=22 (e.g. current Astro)
# has somewhere to run. This just puts its bin dir first on PATH.

if [ -d "$HOME/.local/node22/bin" ]; then
    case ":$PATH:" in
        *":$HOME/.local/node22/bin:"*) ;;
        *) export PATH="$HOME/.local/node22/bin:$PATH" ;;
    esac
fi
