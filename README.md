# Dotfiles

GNU Stow dotfiles for an Arch Linux / Hyprland setup, initially targeted at a Framework Laptop 13.

The desktop is terminal-first, NetworkManager-backed, and themed around Omarchy stock palettes using Hack Nerd Font. Everforest is the active default.

## Layout

- `shared/` is the base home-directory Stow package.
- `laptop/` is the Framework/mobile home-directory Stow profile.
- `desktop/` is reserved for fixed-desktop home-directory overrides.
- `neovim/` is a separate home-directory Stow package whose `neovim/.config/nvim` directory is a Git submodule.
- `system/` contains shared system-level files intended for `/`, currently greetd and the virtual console palette.
- `system-laptop/` contains laptop-only system files, currently Framework charge limiting and suspend/hibernate timing.
- `scripts/` contains repo maintenance and installation helpers.
- `shared/.config/dotfiles/theme.json` is the canonical theme source.
- `shared/.config/hypr/hyprland.lua` is the Hyprland entrypoint.
- `shared/.config/hypr/lua/` contains Hyprland Lua modules.
- `shared/.config/hypr/ecosystem/` contains configs for Hypr ecosystem tools that support explicit config paths.

Hyprland compositor configuration should stay Lua-only. Some separate Hypr ecosystem tools still require `.conf` files. `hypridle.conf` and `hyprsunset.conf` remain at `~/.config/hypr/` because the installed/documented versions look there by default.

## First Install

Install system packages and system files as root. The default profile is `laptop`:

```sh
sudo ./scripts/install-system
```

For a fixed desktop that should avoid Framework/shikane/battery-limit pieces:

```sh
sudo ./scripts/install-system desktop
```

Apply home dotfiles as the user. The default profile is `laptop`:

```sh
./scripts/restow-shared
```

For a fixed desktop:

```sh
./scripts/restow-shared desktop
```

Apply Neovim config as the user:

```sh
stow neovim
```

The root install script enables NetworkManager, Bluetooth, CUPS, Avahi, cups-browsed, and greetd. The `laptop` profile also installs `framework-system`, installs shikane, and enables the Framework battery charge-limit service. It does not install iwd or Impala because NetworkManager is the source of truth for Wi-Fi and WireGuard.

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
- Wofi colors: `shared/.config/wofi/style.css`
- Yazi colors: `shared/.config/yazi/theme.toml`
- Zathura colors: `shared/.config/zathura/zathurarc`
- Hyprland Lua theme: `shared/.config/hypr/lua/theme.lua`
- Hyprlock colors: `shared/.config/hypr/ecosystem/hyprlock-theme.conf`
- Mako notifications: `shared/.config/mako/config`
- Launcher: Wofi is toggled from `SUPER+D` or `SUPER+Space`.
- Tuigreet theme env, greetd config fragments, and the virtual console palette used by the login TTY.
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

Wofi is the launcher and lightweight menu target. `SUPER+D` and `SUPER+Space` run `wofi --show drun`. `power-menu` uses `wofi --dmenu`, with a plain shell menu inside the existing Ghostty popup retained as a fallback.

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

Waybar Wi-Fi actions and `SUPER+SHIFT+W` launch `nmtui` in a floating Ghostty popup through `popup` and `tui-theme`, which applies the current theme to newt-based TUIs via `NEWT_COLORS`.

## Secrets

Bitwarden is terminal-first through `rbw`:

```sh
rbw login
rbw unlock
rbw list
rbw get example.com
rbw get example.com | wl-copy
```

Browser extensions, SSH credentials, GPG, and git credential helpers are not wired to Bitwarden yet.

## Shell

Zsh is configured in `shared/.zshrc` with Starship as the prompt, keychain-managed SSH identities, and terminal-first aliases.

Expected SSH identity names:

```text
~/.ssh/github
~/.ssh/git
```

When either file exists, new interactive Zsh shells add it to the keychain-managed SSH agent so Git can use it. Core aliases include `v` for `nvim`, `ls` as `eza -al --group-directories-first --icons=auto`, and `cat` through `bat --plain --paging=never`.

Shell navigation and search use `zoxide`, `fzf`, `ripgrep`, and `fd` when installed. Ripgrep defaults live in `shared/.config/ripgrep/ripgreprc`. Yazi keeps its normal `yazi` command, and `yy` launches Yazi with shell integration so the parent shell changes to Yazi's final directory on exit.

## Files And Viewers

Yazi is the terminal file manager. `SUPER+E` opens it in Ghostty, and `yy` keeps shell-directory handoff for interactive terminal sessions.

Default openers:

- PDFs, ePub, and XPS: Zathura.
- Images: imv.
- Audio and video: mpv.
- Office documents: LibreOffice.
- Text, Markdown, JSON, YAML, TOML, and XML: Neovim.
- Directories: Yazi.

XDG MIME defaults live in `shared/.config/mimeapps.list`. `mailto` and `magnet` are intentionally unset until mail and torrent tools are chosen.

Removable media is explicit rather than automounted:

```sh
media
media list
```

The menu lists removable devices, mounts with `udisksctl`, opens mounted filesystems in Yazi, and can unmount or power off the device. `SUPER+SHIFT+M` opens the media menu in a floating terminal.

## Browser

Firefox is the default browser baseline. Browser work should keep these decisions explicit:

- Firefox is the default handler for `http` and `https`.
- Native Wayland and XDG portals are expected under Hyprland.
- Dark mode comes from GTK settings and the portal GTK settings backend.
- PDFs opened as files go to Zathura; browser-internal PDF behavior remains Firefox default.
- Downloads should open through the MIME defaults above.
- Screen sharing should be validated through `xdg-desktop-portal-hyprland`.
- Chromium is not part of the baseline unless a compatibility need appears.

## Neovim

LazyVim lives in the `neovim/.config/nvim` submodule and is stowed separately:

```sh
stow neovim
```

The submodule uses the Everforest Neovim colorscheme to match the system theme
and enables LazyVim extras for Go, Node.js, JavaScript, TypeScript, Rust, C,
and C++ development.

Recommended Arch packages for that editor workflow:

```sh
sudo pacman -S --needed base-devel clang clang-tools-extra cmake gcc gdb go lldb nodejs npm rustup stylua
rustup default stable
rustup component add rust-analyzer clippy rustfmt
```

LazyVim/Mason manages editor-side language servers, formatters, linters, test
adapters, and debugger adapters where practical. System packages above provide
the real compilers, runtimes, build tools, and Rust toolchain components.

## Power And Idle

Hypridle is configured for:

- 5 minutes: lock and dim.
- 10 minutes: display off.
- 15 minutes: suspend-then-hibernate only when on battery.
- When plugged in: stop at locked plus display off; do not suspend or hibernate.
- 15 minutes after a battery suspend: hibernate via systemd sleep settings.

Power actions are centralized in `power`. The TUI-style floating power menu is `power-menu`, and `toggle-power-menu` is used by both `SUPER+SHIFT+P` and the Waybar power icon.

Power profiles use `power-profiles-daemon`. The Waybar power profile icon opens `power-profile-menu`, which selects `balanced`, `power-saver`, or `performance`.

Framework battery charge limiting is part of the `laptop` profile. It uses the official `framework_tool` from `framework-system`, not sysfs charge threshold files. The default daily cap is 80%, applied by `battery-limit.service` at boot:

```sh
battery-limit status
battery-limit 80
battery-limit 100
battery-limit power
```

Use `battery-limit 100` as a travel override before needing maximum runtime. `battery-watch` starts with Hyprland and sends low-battery notifications while discharging.

Firmware checks use `fwupd` manually:

```sh
fwupdmgr refresh
fwupdmgr get-updates
fwupdmgr update
```

## Bluetooth And Audio

Bluetooth is handled by BlueZ. `SUPER+SHIFT+B` and the Waybar Bluetooth icon open `bluetui`; `bluetoothctl` remains the terminal fallback for pairing and trust/connect flows.

Audio is PipeWire through WirePlumber. Media keys use `wpctl`, and `SUPER+SHIFT+A` or the Waybar audio icon opens `wiremix` for sink/source selection and levels.

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

Dynamic dock and roaming display profiles are part of the `laptop` profile and handled by shikane:

```text
laptop/.config/shikane/config.toml
```

Profiles:

- `laptop`: only `eDP-1`, best mode, scale `1.3333333333333333` (`160/120`, the exact fractional step Hyprland expects for roughly 133%).
- `docked-home-dell`: disables `eDP-1` and enables the home Dell monitor. Replace `TODO_HOME_DELL_SERIAL` once docked.
- `roaming-*`: keeps `eDP-1` enabled and enables one to three generic external `DP-*`/`HDMI-A-*` outputs at best mode.

When docked at home, discover the exact monitor attributes:

```sh
hyprctl monitors all
shikanectl export
```

Then update the Dell `search` field in `laptop/.config/shikane/config.toml`, run:

```sh
./scripts/restow-shared
systemctl --user restart shikane.service
```

## Desktop Profile

The `desktop` package is intentionally minimal for now. A desktop with one stable monitor should put its fixed Hyprland monitor rules in:

```text
desktop/.config/hypr/lua/profile_outputs.lua
```

The shared Hyprland entrypoint loads `profile_outputs.lua` when the selected profile provides it. Install a desktop with:

```sh
sudo ./scripts/install-system desktop
./scripts/restow-shared desktop
```
