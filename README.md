# .dotfiles

Personal dotfiles managed with GNU Stow.

This repo is organized around small, composable packages instead of one giant machine-specific setup. The goal is to keep a clean base configuration that works across Debian-based systems, then layer optional profiles on top.

## Scope

This repo installs **symlinks only**.

Package installation and system-wide config deployment moved to [paperweight-os](https://github.com/jalexlong/paperweight-os) and are handled by `apt install paperweight-desktop`. The `scripts/packages-*.sh` files that used to live here are gone and are not coming back. Do not re-add apt logic to `install.sh`.

What stays here is per-user configuration that Stow links into `$HOME`.

## Current profiles

| Profile | Purpose | Applies |
|---|---|---|
| `base` | Minimal shell/editor/tmux setup | `common` |
| `popos` | Pop!_OS / COSMIC laptop | `common`, `kitty`, `cosmic` |

The `sway` and `chromebook` profiles were removed. Those desktops are owned by `paperweight-skel` and `paperweight-chromebook` now.

## Repo layout

```text
.dotfiles/
├── README.md
├── install.sh
├── scripts/
│   ├── _stow-lib.sh
│   ├── apply-base.sh
│   ├── apply-popos.sh
│   └── ensure-shell-loaders.sh
│
├── common/
│   ├── .bash_aliases
│   ├── .bash_functions
│   ├── .gitconfig
│   ├── .tmux.conf
│   ├── .vimrc
│   ├── .config/nvim/init.vim
│   ├── .profile.d/
│   │   ├── rust.sh
│   │   ├── user-env.sh
│   │   └── wayland.sh
│   ├── .ssh/config
│   └── .local/bin/qanba-xinput
│
├── kitty/
│   └── .config/kitty/kitty.conf
│
└── cosmic/
    └── .config/cosmic/
        ├── com.system76.CosmicTerm/v1/
        └── com.system76.CosmicSettings.Shortcuts/v1/
```

## Design

Each top-level directory such as `common`, `kitty`, and `cosmic` mirrors paths relative to `$HOME`.

For example:

```text
.dotfiles/common/.bash_aliases
```

stows to:

```text
~/.bash_aliases
```

Do not run:

```bash
stow .
```

Use named packages only.

## Install

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

Applying a profile is idempotent. Re-run it after a pull to pick up newly added packages.

The apply scripts dry-run every package before touching anything, so a conflict in the last package will not leave the first few half-applied.

## The `cosmic` package

This package tracks COSMIC Terminal's settings and the COSMIC shortcut that decides which terminal `Super+T` opens.

COSMIC stores config as one file per key under a versioned directory:

```text
~/.config/cosmic/com.system76.CosmicTerm/v1/font_name
~/.config/cosmic/com.system76.CosmicTerm/v1/font_size
```

Stow folds each app directory into a **single directory symlink**, not per-file symlinks:

```text
~/.config/cosmic/com.system76.CosmicTerm -> ../../.dotfiles/cosmic/.config/cosmic/com.system76.CosmicTerm
```

That is deliberate. `cosmic-config` saves a setting by writing a temp file and renaming it over the old one. A rename over a *per-file* symlink replaces the link with a regular file and silently detaches that key from this repo. With the directory linked instead, the rename lands inside the repo, so changes made in COSMIC Settings show up as an ordinary `git diff`.

Check for detachment with:

```bash
ls -la ~/.config/cosmic/ | grep -i cosmic
```

Both entries must be symlinks. If one became a real directory, re-link it:

```bash
rm -rf ~/.config/cosmic/com.system76.CosmicTerm
stow -v -R -d "$HOME/.dotfiles" -t "$HOME" cosmic
```

### Font choice is load-bearing

`font_name` is `JetBrainsMonoNL Nerd Font Mono` rather than a Meslo variant for a specific reason.

cosmic-term renders box-drawing characters from the font. It does not synthesize them. Its line box measures 1.600 em, and no installed Nerd Font ships a `U+2502` glyph that tall, so tmux pane borders always show a sub-pixel seam:

| font | `│` glyph height | gap in a 16 px cell |
|---|---|---|
| MesloLGS NFM | 1.274 em | 3.26 px per row |
| JetBrainsMonoNL NFM | 1.520 em | 0.80 px per row |

JetBrains Mono is the least-bad option there. It is not a fix; the deficit is a fixed 5% of the line box, so no font size scales it away.

kitty draws box-drawing characters itself (`kitty/fonts/box_drawing.py` fills rows `0..cell_height` at full opacity), so its borders are seamless at any font and size. That is why kitty is the default terminal.

## Default terminal

Three separate mechanisms decide which terminal opens. Two are user-level and tracked or scripted; one needs root.

| Mechanism | Used by | Set by |
|---|---|---|
| `CosmicSettings.Shortcuts/v1/system_actions` | COSMIC `Super+T` | the `cosmic` package |
| `x-scheme-handler/terminal`, `application/x-terminal-emulator` | XDG apps, "Open in terminal" | `xdg-mime` (see below) |
| `update-alternatives x-terminal-emulator` | Debian scripts, some apps | root, once per machine |

The XDG handlers live in `~/.config/mimeapps.list`, which is not tracked because it also carries unrelated per-machine associations:

```bash
xdg-mime default kitty.desktop x-scheme-handler/terminal
xdg-mime default kitty.desktop application/x-terminal-emulator
```

The Debian alternative needs root and is intentionally not done by `install.sh`:

```bash
sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty
```

Verify all three:

```bash
cat ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/system_actions
xdg-mime query default x-scheme-handler/terminal
update-alternatives --query x-terminal-emulator | grep '^Value'
```

## Shell startup files

This repo does not replace Debian or Pop!_OS default shell startup files.

`scripts/ensure-shell-loaders.sh` patches the existing ones idempotently so distro updates to `~/.bashrc` and `~/.profile` keep flowing. It appends only what is missing:

```text
~/.bashrc   ->  ~/.bash_aliases, ~/.bash_functions
~/.profile  ->  ~/.profile.d/*.sh
```

Environment variables live in `common/.profile.d/user-env.sh`.

### Prompt color

The prompt is set in `common/.bash_aliases`, not in `~/.bashrc`.

Stock Ubuntu gates the color prompt on a TERM *name* whitelist:

```bash
case "$TERM" in xterm-color|*-256color) color_prompt=yes;; esac
```

cosmic-term sets `TERM=xterm-256color` and matches. kitty sets `TERM=xterm-kitty` and matches neither pattern, so the prompt silently falls back to plain white outside tmux. `.bash_aliases` is sourced after `~/.bashrc` sets `PS1`, so it redefines the prompt based on actual `tput setaf` capability instead of the terminal's name.

That block also re-adds the `user@host: dir` window title escape, which `~/.bashrc` sets before `.bash_aliases` runs and which redefining `PS1` would otherwise drop.

## Testing

Check Bash syntax:

```bash
cd "$HOME/.dotfiles"
bash -n install.sh scripts/*.sh
```

Dry-run a package:

```bash
stow -n -v -d "$HOME/.dotfiles" -t "$HOME" common
stow -n -v -d "$HOME/.dotfiles" -t "$HOME" kitty
stow -n -v -d "$HOME/.dotfiles" -t "$HOME" cosmic
```

Apply or restow a package manually:

```bash
stow -v -S -d "$HOME/.dotfiles" -t "$HOME" common
stow -v -R -d "$HOME/.dotfiles" -t "$HOME" common
```

Use `-S` for normal installs. Use `-R` when cleaning up and recreating symlinks.

## Troubleshooting

### Stow reports a conflict

```text
existing target is neither a link nor a directory
```

A real file already sits where Stow wants a symlink. Back it up first:

```bash
mv ~/.tmux.conf ~/.tmux.conf.backup
```

Then re-run the apply script.

### A COSMIC setting stopped tracking in git

See "The `cosmic` package" above. The app directory probably got replaced with a real directory. Re-link it with `stow -R`.

### tmux pane borders look like stacked `|` marks

The font's box-drawing glyph is shorter than the terminal's line box. This is a font and terminal-renderer problem, never a tmux or locale problem — tmux emits real `U+2502` whenever the client is UTF-8, which `tmux list-clients -F '#{client_utf8}'` will confirm.

Use kitty, which draws the characters itself. In cosmic-term the seam can be reduced but not eliminated.

### Prompt is white in kitty but green in cosmic-term

The `common` package is not applied, or `~/.bashrc` is not sourcing `~/.bash_aliases`. Run `./scripts/ensure-shell-loaders.sh`.

## Normal workflow

```bash
cd "$HOME/.dotfiles"
git status
git add -A
git commit -m "update dotfiles"
git push
```

Then on another machine:

```bash
cd "$HOME/.dotfiles"
git pull --ff-only
./install.sh popos
```

## Notes

Base should stay boring.

No apt logic in this repo. That belongs to paperweight-os.

Machine-specific hardware tweaks should live in their own overlay package, not in `common`.
