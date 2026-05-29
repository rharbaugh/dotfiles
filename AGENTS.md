# AGENTS.md

## Project Direction

This is a GNU Stow dotfiles repository for an Arch Linux system using Hyprland. The initial hardware target is a Framework Laptop 13.

The long-term goal is a cohesive, opinionated desktop environment in the spirit of Omarchy, but built around this repository's own preferences. Configuration should be developed program by program, with each major component eventually supporting a terminal-first workflow and a coherent visual theme.

The system is assumed to be migrating from a KDE-oriented setup toward a Hyprland-based environment where common desktop needs are still covered, but the daily workflow stays keyboard-driven and terminal-centered wherever practical.

## Operating Assumptions

- OS: Arch Linux.
- Desktop/session: Hyprland on Wayland.
- Hardware baseline: Framework Laptop 13 unless a task states otherwise.
- Dotfiles manager: GNU Stow.
- Workflow preference: terminal-based, keyboard-first, minimal mouse dependency.
- Design preference: coherent system-wide theming across terminal, shell, editor, launcher, bar, notifications, lock screen, file management, and desktop utilities.
- Theme preference: use Omarchy's Ethereal theme where practical, adapted to this repo instead of depending on Omarchy's full theme machinery.
- Font preference: use `ttf-hack-nerd` / Hack Nerd Font for terminal and desktop UI typography.
- Network preference: keep NetworkManager as the network authority, including Wi-Fi and WireGuard; use `nmtui`/`nmcli` for terminal workflows rather than standalone iwd/Impala.
- Scope: eventually replace or cover the major practical components of a former KDE setup without recreating KDE itself.

## Repository Layout

Use Stow package directories at the repository root. Each package should mirror paths relative to `$HOME`.

Example:

```text
shared/
  .config/
    hypr/
    waybar/
```

Prefer grouping files by installable package or shared concern rather than scattering unrelated configuration together. If a config applies broadly across the system, `shared/` is appropriate. If a tool grows into its own meaningful unit, create a dedicated Stow package for it.

System-level files that do not belong under `$HOME` may live in a separate package such as `system/`, intended to be installed explicitly with a root target such as `sudo stow -t / system`.

Avoid hard-coding machine-specific paths or secrets. When host-specific behavior is needed, prefer small sourced override files, documented environment variables, or clearly named host packages.

## Configuration Priorities

When configuring a program, optimize for:

1. Keyboard-driven interaction.
2. Fast terminal access and composability.
3. Visual consistency with the rest of the system.
4. Simple, inspectable configuration over opaque automation.
5. Arch-native package availability where possible.
6. A clean migration path from KDE-era defaults.

Prefer terminal user interfaces and CLI tools when they provide a good daily experience. GUI tools are fine when they are meaningfully better for the task, but they should still integrate with the theme and keyboard workflow.

## Theming

Treat theming as a system-level concern, not a per-program afterthought.

- Keep colors, fonts, spacing, and interaction states consistent across components.
- Prefer a small shared palette that can be reused by terminal, Waybar, launcher, notifications, editor, and lock screen.
- Prefer Omarchy Ethereal colors when no stronger local preference exists.
- Prefer Hack Nerd Font from `ttf-hack-nerd` for UI and terminal text.
- Document theme decisions as they emerge.
- Avoid one-off styling unless there is a clear reason.
- When possible, define theme values in a reusable location and import them into tool-specific configs.

The canonical theme source is `shared/.config/dotfiles/theme.json`. Regenerate app-specific theme fragments with `dotfiles-apply-theme` after changing it.

## Hyprland System Components

Over time, expect the repo to cover the practical pieces of a complete desktop:

- Hyprland session configuration.
- Waybar or another status bar.
- Launcher and command palette.
- Terminal emulator.
- Shell and prompt.
- Editor.
- Notifications.
- Lock screen and idle handling.
- Wallpaper and theme management.
- Clipboard tooling.
- Screenshot and screen recording tools.
- Audio, Bluetooth, Wi-Fi, brightness, and power workflows.
- File management, preferably terminal-first.
- Package/update helpers.
- Session startup and environment variables.
- XDG portals and Wayland integration.

When replacing KDE functionality, preserve the useful workflow outcome rather than copying KDE behavior directly.

## Development Workflow

- Read existing configuration before editing.
- Keep changes scoped to the program or system component currently being configured.
- Follow existing file formats and local style.
- Prefer small, understandable commits at meaningful milestones.
- Commit changes whenever a major feature or component configuration is completed.
- Do not mix unrelated program configuration changes in the same commit when they can be separated cleanly.
- Leave unrelated untracked or modified files alone.

Before committing, check:

```sh
git status --short
```

For Stow package changes, verify the intended links with a dry run when practical:

```sh
stow --no --verbose <package>
```

Use real validation commands for the program being changed when available, such as format checks, config parsers, or service reload tests.

## Documentation Expectations

As each program is configured, document the important choices close to the relevant files or in a concise repo note. Useful documentation includes:

- Why the tool was chosen.
- Important keybindings.
- Required packages.
- Theme integration points.
- Any migration notes from KDE or previous defaults.
- Any Framework Laptop 13 assumptions.

Keep documentation practical. It should help future work move faster without becoming a separate manual.

## Agent Guidance

When working in this repo:

- Assume the user wants implementation, not just a plan, unless they explicitly ask for discussion only.
- Preserve user changes and unrelated untracked files.
- Use terminal-first tools and Arch/Hyprland conventions by default.
- Prefer coherent, maintainable configuration over clever shortcuts.
- Ask before introducing large new dependencies or opinionated framework-level changes.
- If a task completes a major component or feature, commit the finished changes.
- If a task is exploratory or partial, do not force a commit unless the user asks.
