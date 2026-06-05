# Desktop Profile

This Stow package is reserved for fixed-desktop overrides.

For a desktop with one stable monitor, add machine-specific Hyprland output
rules in:

```text
desktop/.config/hypr/lua/profile_outputs.lua
```

The shared Hyprland entrypoint loads that module when present.
