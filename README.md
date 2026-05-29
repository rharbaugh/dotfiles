# Dotfiles

GNU Stow dotfiles for an Arch Linux / Hyprland setup, initially targeted at a Framework Laptop 13.

The desktop is terminal-first, NetworkManager-backed, and themed around an Omarchy Ethereal-inspired palette using Hack Nerd Font.

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

Edit:

```sh
shared/.config/dotfiles/theme.json
```

Regenerate all checked-in theme fragments:

```sh
./scripts/apply-theme
```

Apply regenerated files to `$HOME`:

```sh
./scripts/restow-shared
```

The generator writes:

- Ghostty colors: `shared/.config/ghostty/theme.conf`
- Waybar colors: `shared/.config/waybar/theme.css`
- Hyprland Lua theme: `shared/.config/hypr/lua/theme.lua`
- Hyprlock colors: `shared/.config/hypr/ecosystem/hyprlock-theme.conf`
- Mako notifications: `shared/.config/mako/config`
- Walker CSS variables: `shared/.config/walker/themes/theme.css`
- Tuigreet theme env and greetd config fragments.

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

Waybar Wi-Fi actions and `SUPER+SHIFT+W` launch `nmtui` in Ghostty through `dotfiles-tui`, which applies the current theme to newt-based TUIs via `NEWT_COLORS`.

## Power And Idle

Hypridle is configured for:

- 5 minutes: lock and dim.
- 10 minutes: display off.
- 15 minutes: suspend-then-hibernate only when on battery.
- When plugged in: stop at locked plus display off; do not suspend or hibernate.
- 15 minutes after a battery suspend: hibernate via systemd sleep settings.

Power actions are centralized in `dotfiles-power`. The TUI-style power menu is `dotfiles-power-menu`, and `dotfiles-toggle-power-menu` is used by both `SUPER+SHIFT+P` and the Waybar power icon.

## Screenshots

Region screenshot to clipboard:

```text
SUPER+SHIFT+S
```

Requires `grim`, `slurp`, and `wl-clipboard`.

## UWSM

The Hyprland wiki's systemd startup page says that, in a UWSM-managed session, application startup commands should be prefixed with `uwsm app --`.

Autostart uses UWSM when available and active, with a direct fallback otherwise. This keeps the config usable from both UWSM-managed and plain Hyprland sessions.

Choose `hyprland (uwsm-managed)` in greetd/display-manager sessions when available.
