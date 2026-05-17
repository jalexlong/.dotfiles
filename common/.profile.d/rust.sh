# Rust/Cargo environment

# Debian/Pop!_OS rustup from apt may not create ~/.cargo/env.
# Add Cargo's user binary directory to PATH when present.

export CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$HOME/.rustup}"

if [ -d "$HOME/.cargo/bin" ]; then
    case ":$PATH:" in
        *":$CARGO_HOME/bin:"*) ;;
        *) export PATH="$CARGO_HOME/bin:$PATH" ;;
    esac
fi
