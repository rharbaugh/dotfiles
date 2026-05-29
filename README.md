# Dotfiles

GNU Stow dotfiles for an Arch Linux / Hyprland setup, initially targeted at a Framework Laptop 13.

The desktop is terminal-first, NetworkManager-backed, and themed around Omarchy stock palettes using Hack Nerd Font. Everforest is the active default.

## Layout

- `shared/` is the home-directory Stow package.
- `system/` contains system-level files intended for `/`, currently greetd.
- `scripts/` contains repo maintenance and installation helpers.
- `shared/.config/dotfiles/theme.json` is the canonical theme source.
- `shared/.config/hypr/hyprland.lua` is the Hyprland entrypoint.
- `shared/.config/hypr/lua/` contains Hyprland Lua modules.
- `shared/.config/hypr/ecosystem/` contains configs for Hypr ecosystem tools that support explicit config paths.

Hyprland compositor configuration should stay Lua-only. Some separate Hypr ecosystem tools still require `.conf` files. `hypridle.conf` and `hyprsunset.conf` remain at `~/.config/hypr/` because the installed/documented versions look there by default.

## First Install

Install system packages and system files as root:

```sh
sudo ./scripts/install-system
```

Apply home dotfiles as the user:

```sh
./scripts/restow-shared
```

The root install script enables NetworkManager, Bluetooth, CUPS, Avahi, cups-browsed, and greetd. It does not install iwd or Impala because NetworkManager is the source of truth for Wi-Fi and WireGuard.

## Theme Workflow

The active theme is:

```sh
shared/.config/dotfiles/theme.json
```

Stock Omarchy theme sources are kept ready to apply under:

```sh
shared/.config/dotfiles/themes/
```

Regenerate all checked-in theme fragments:

```sh
./scripts/apply-theme
```

Switch to a stock theme, such as Ethereal:

```sh
./scripts/apply-theme ethereal
```

Apply regenerated files to `$HOME`:

```sh
./scripts/restow-shared
```

Apply regenerated login screen and other system files:

```sh
sudo ./scripts/install-system
```

The generator writes:

- Ghostty colors: `shared/.config/ghostty/theme.conf`
- Waybar colors: `shared/.config/waybar/theme.css`
- Yazi colors: `shared/.config/yazi/theme.toml`
- Hyprland Lua theme: `shared/.config/hypr/lua/theme.lua`
- Hyprlock colors: `shared/.config/hypr/ecosystem/hyprlock-theme.conf`
- Mako notifications: `shared/.config/mako/config`
- Launcher: Walker is toggled from `SUPER+D` or `SUPER+Space`.
- Tuigreet theme env and greetd config fragments.
- Qt control palettes: `shared/.config/qt5ct/` and `shared/.config/qt6ct/`

Dark mode is advertised through GTK settings, `gsettings`, and XDG Desktop Portal's GTK settings backend. GUI apps and browsers that follow the system color scheme should see `prefer-dark` after the session restarts. GTK uses `Adwaita-dark`; Qt uses Fusion plus the generated qtct dark palette, with Qt6 active by default through `QT_QPA_PLATFORMTHEME=qt6ct`.

## Hyprland Config

Hyprland loads only Lua modules:

```text
shared/.config/hypr/hyprland.lua
shared/.config/hypr/lua/*.lua
```

The modules are split by purpose:

- `outputs.lua`
- `inputs.lua`
- `autostart.lua`
- `binds.lua`
- `look.lua`
- `layouts.lua`
- `rules.lua`
- `env.lua`
- `settings.lua`
- `theme.lua`

If stale links exist in `~/.config/hypr` after a layout change, run:

```sh
./scripts/restow-shared
```

## Launcher

Walker is the launcher/menu target, matching Omarchy's current launcher direction. It is not in the official Arch repositories on this system, so install it from the AUR:

```sh
paru -S walker-bin
```

or:

```sh
yay -S walker-bin
```

Remove the old launcher package when no longer needed:

```sh
sudo pacman -Rns hyprlauncher
```

`SUPER+D` and `SUPER+Space` run `walker`. `dotfiles-power-menu` uses `walker --dmenu` when Walker is installed, with the older Gum/Ghostty menu retained as a fallback.

## Network

Use NetworkManager:

```sh
sudo systemctl enable --now NetworkManager.service
```

Terminal UI:

```sh
nmtui
```

Command-line control:

```sh
nmcli
```

Waybar Wi-Fi actions and `SUPER+SHIFT+W` launch `nmtui` in a floating Ghostty popup through `dotfiles-popup` and `dotfiles-tui`, which applies the current theme to newt-based TUIs via `NEWT_COLORS`.

## Shell

Zsh is configured in `shared/.zshrc` with Starship as the prompt, keychain-managed SSH identities, and terminal-first aliases.

Expected SSH identity names:

```text
~/.ssh/github
~/.ssh/git
```

When either file exists, new interactive Zsh shells add it to the keychain-managed SSH agent so Git can use it. Core aliases include `v` for `nvim`, `ls` as `eza -al --group-directories-first --icons=auto`, and `cat` through `bat --paging=never`.

Shell navigation and search use `zoxide`, `fzf`, `ripgrep`, and `fd` when installed. Ripgrep defaults live in `shared/.config/ripgrep/ripgreprc`. Yazi keeps its normal `yazi` command, and `yy` launches Yazi with shell integration so the parent shell changes to Yazi's final directory on exit.

## Power And Idle

Hypridle is configured for:

- 5 minutes: lock and dim.
- 10 minutes: display off.
- 15 minutes: suspend-then-hibernate only when on battery.
- When plugged in: stop at locked plus display off; do not suspend or hibernate.
- 15 minutes after a battery suspend: hibernate via systemd sleep settings.

Power actions are centralized in `dotfiles-power`. The TUI-style floating power menu is `dotfiles-power-menu`, and `dotfiles-toggle-power-menu` is used by both `SUPER+SHIFT+P` and the Waybar power icon.

## Screenshots

Region screenshot to clipboard:

```text
SUPER+SHIFT+S
```

Requires `grim`, `slurp`, and `wl-clipboard`.

## UWSM

The Hyprland wiki's systemd startup page says that, in a UWSM-managed session, application startup commands should be prefixed with `uwsm app --`.

Autostart uses UWSM when available and active, with a direct fallback otherwise. This keeps the config usable from both UWSM-managed and plain Hyprland sessions.

Greetd launches the default session with `uwsm start hyprland.desktop`, so Hyprland enters through the UWSM-managed path.

Waybar is skipped by the Hyprland autostart in UWSM-managed sessions so the user systemd service path can own it. Plain Hyprland sessions still get a direct `waybar` fallback.

## Displays

Dynamic dock and roaming display profiles are handled by shikane:

```text
shared/.config/shikane/config.toml
```

Profiles:

- `laptop`: only `eDP-1`, best mode, scale `1.33`.
- `docked-home-dell`: disables `eDP-1` and enables the home Dell monitor. Replace `TODO_HOME_DELL_SERIAL` once docked.
- `roaming-*`: keeps `eDP-1` enabled and enables one to three generic external `DP-*`/`HDMI-A-*` outputs at best mode.

When docked at home, discover the exact monitor attributes:

```sh
hyprctl monitors all
shikanectl export
```

Then update the Dell `search` field in `shared/.config/shikane/config.toml`, run:

```sh
./scripts/restow-shared
systemctl --user restart shikane.service
```
