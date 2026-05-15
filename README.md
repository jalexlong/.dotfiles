# .dotfiles

Personal dotfiles managed with GNU Stow.

This repo is organized around small, composable packages instead of one giant machine-specific setup. The goal is to keep a clean base configuration that works across Debian-based systems, then layer optional profiles on top.

## Current profiles

| Profile | Purpose | Applies |
|---|---|---|
| `base` | Minimal shell/editor/tmux setup | `common` |
| `popos` | Regular Pop!_OS / COSMIC laptop setup | `common`, `kitty` |
| `sway` | Lightweight Wayland setup for restricted hardware | `common`, `kitty`, `sway` |

Future profiles may include:

| Profile | Purpose |
|---|---|
| `chromebook` | Hardware-specific overrides for `paperweight-pro` |
| `ctf` | CTF / attackbox tooling and helper scripts |

## Repo layout

```text
.dotfiles/
├── README.md
├── install.sh
├── scripts/
│   ├── apply-base.sh
│   ├── apply-popos.sh
│   ├── apply-sway.sh
│   ├── ensure-shell-loaders.sh
│   ├── packages-base-debian.sh
│   ├── packages-base-popos.sh
│   ├── packages-kitty-debian.sh
│   ├── packages-sway-debian.sh
│   └── packages-ctf-debian.sh
│
├── common/
│   ├── .bash_aliases
│   ├── .bash_functions
│   ├── .profile.d/
│   │   └── user-env.sh
│   ├── .vimrc
│   ├── .tmux.conf
│   └── .local/
│       └── bin/
│           └── dotfiles
│
├── kitty/
│   └── .config/
│       └── kitty/
│           └── kitty.conf
│
└── sway/
    └── .config/
        ├── sway/
        │   └── config
        ├── waybar/
        │   ├── config.jsonc
        │   └── style.css
        ├── mako/
        │   └── config
        └── wofi/
            └── config
```

## Design

The repo uses GNU Stow packages.

Each top-level directory such as `common`, `kitty`, and `sway` mirrors paths relative to `$HOME`.

For example:

```text
.dotfiles/common/.bash_aliases
```

stows to:

```text
~/.bash_aliases
```

And:

```text
.dotfiles/kitty/.config/kitty/kitty.conf
```

stows to:

```text
~/.config/kitty/kitty.conf
```

Do not run:

```bash
stow .
```

Use named packages only.

## Base setup

The base profile is intentionally minimal.

It applies:

```text
common
```

This includes shell aliases, Bash functions, Vim config, tmux config, user environment snippets, and helper scripts.

It does not install or apply Sway, Waybar, Mako, Wofi, or other graphical desktop configuration.

### Install base profile

```bash
git clone https://github.com/jalexlong/.dotfiles "$HOME/.dotfiles"
cd "$HOME/.dotfiles"
./install.sh base
```

## Pop!_OS / COSMIC setup

Use this on the regular laptop running Pop!_OS with COSMIC.

This applies:

```text
common
kitty
```

It does not apply Sway or Waybar.

### Install Pop!_OS profile

```bash
git clone https://github.com/jalexlong/.dotfiles "$HOME/.dotfiles"
cd "$HOME/.dotfiles"
./install.sh popos
```

If the repo already exists:

```bash
cd "$HOME/.dotfiles"
git pull --ff-only
./install.sh popos
```

## Sway setup

Use this on restricted hardware or machines where Sway is the intended desktop environment.

This applies:

```text
common
kitty
sway
```

The Sway package is expected to contain:

```text
~/.config/sway/config
~/.config/waybar/config.jsonc
~/.config/waybar/style.css
~/.config/mako/config
~/.config/wofi/config
```

### Install Sway profile

```bash
git clone https://github.com/jalexlong/.dotfiles "$HOME/.dotfiles"
cd "$HOME/.dotfiles"
./install.sh sway
```

If the repo already exists:

```bash
cd "$HOME/.dotfiles"
git pull --ff-only
./install.sh sway
```

### Validate Sway config

Before launching Sway:

```bash
sway --validate
```

Start Sway:

```bash
sway
```

Reload Sway after config changes:

```bash
swaymsg reload
```

## Shell startup files

This repo does not replace Debian or Pop!_OS default shell startup files.

Instead, the installer patches existing files lightly.

### `.bashrc`

The installer ensures `~/.bashrc` loads:

```text
~/.bash_aliases
~/.bash_functions
```

These files are managed by the `common` Stow package.

### `.profile`

The installer ensures `~/.profile` loads:

```text
~/.profile.d/*.sh
```

This allows the repo to manage user environment variables without overwriting the operating system’s default `~/.profile`.

Environment variables live in:

```text
common/.profile.d/user-env.sh
```

Examples:

```bash
export EDITOR=vim
export VISUAL=vim
export PAGER=less
```

## Package scripts

Package installation is split by purpose and distro family.

```text
scripts/packages-base-debian.sh      base Debian packages
scripts/packages-base-popos.sh       base Pop!_OS packages
scripts/packages-kitty-debian.sh     Kitty and font packages
scripts/packages-sway-debian.sh      Sway, Waybar, Mako, Wofi, screenshot tools
scripts/packages-ctf-debian.sh       optional CTF tooling
```

The base package list should stay conservative.

Optional or heavy packages should not go in base.

## Applying dotfiles without installing packages

Use these scripts when packages are already installed and you only want to relink dotfiles.

### Base

```bash
cd "$HOME/.dotfiles"
./scripts/apply-base.sh
```

### Pop!_OS

```bash
cd "$HOME/.dotfiles"
./scripts/apply-popos.sh
```

### Sway

```bash
cd "$HOME/.dotfiles"
./scripts/apply-sway.sh
```

## Normal workflow

### Edit on primary laptop

```bash
cd "$HOME/.dotfiles"
git status
```

Make changes, then:

```bash
git add -A
git commit -m "update dotfiles"
git push
```

### Pull on Chromebook or other machine

```bash
cd "$HOME/.dotfiles"
git pull --ff-only
./install.sh sway
```

Or, if packages are already installed:

```bash
cd "$HOME/.dotfiles"
git pull --ff-only
./scripts/apply-sway.sh
swaymsg reload
```

## Testing scripts

Before running install scripts, check Bash syntax:

```bash
cd "$HOME/.dotfiles"
bash -n install.sh
bash -n scripts/*.sh
```

If those commands print nothing, the syntax is valid.

## Testing Stow

Dry-run a package before applying it:

```bash
stow -n -v -d "$HOME/.dotfiles" -t "$HOME" common
stow -n -v -d "$HOME/.dotfiles" -t "$HOME" kitty
stow -n -v -d "$HOME/.dotfiles" -t "$HOME" sway
```

Apply a package manually:

```bash
stow -v -S -d "$HOME/.dotfiles" -t "$HOME" common
```

Restow a package manually:

```bash
stow -v -R -d "$HOME/.dotfiles" -t "$HOME" common
```

Use `-S` for normal installs.

Use `-R` when intentionally cleaning up and recreating symlinks.

## Current machine usage

### Pop!_OS laptop

```bash
cd "$HOME/.dotfiles"
./install.sh popos
```

Expected result:

```text
common applied
kitty applied
sway not applied
```

### Chromebook / restricted hardware

```bash
cd "$HOME/.dotfiles"
./install.sh sway
```

Expected result:

```text
common applied
kitty applied
sway applied
```

## Troubleshooting

### `E: Unable to locate package fastfetch`

The package is not available from the current default apt repositories.

Do not keep nonessential packages like `fastfetch` in the base package list unless the target distro reliably provides them.

Put optional visual/fun packages in a separate script later.

### `unexpected EOF while looking for matching quote`

Run:

```bash
bash -n scripts/*.sh
```

This usually means a missing quote or broken heredoc in one of the shell scripts.

### Stow reports a conflict

Example:

```text
existing target is neither a link nor a directory
```

That means a real file already exists where Stow wants to create a symlink.

Back it up first:

```bash
mv ~/.tmux.conf ~/.tmux.conf.backup
```

Then re-run the relevant apply script.

### Sway does not start

Validate first:

```bash
sway --validate
```

Run Waybar directly to see Waybar errors:

```bash
waybar
```

Reload Sway:

```bash
swaymsg reload
```

## Notes

Base should stay boring.

Sway should stay optional.

CTF tools should stay optional.

Machine-specific hardware tweaks should eventually live in their own overlay package, not in `common`.

