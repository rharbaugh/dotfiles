# TODO

Planned follow-up work, in intended order.

1. GPG key generation and agent config
   - Generate a personal GPG key suitable for Git signing and mail.
   - Add repo-managed `gpg-agent` guidance after choosing how to avoid managing private key directories with Stow.
   - Done: add `gnupg`/`pinentry` to the system package baseline and export/update `GPG_TTY` from Zsh.
   - Add GitHub GPG public key upload notes.

2. Git configuration
   - Add a repo-managed Git config package.
   - Configure identity, default branch, signing, pull behavior, and useful aliases.
   - Verify Lazygit works cleanly with signed commits.

3. Browser and portal testing
   - Verify xdg-desktop-portal behavior under Hyprland.
   - Test file picker, screen sharing, URI opening, and dark-mode hints.
   - Configure browser defaults and portal-related environment as needed.

4. Backup and secrets
   - Choose a secrets approach such as `sops`/`age`, `pass`, or `gopass`.
   - Document what belongs in Git and what must stay local/encrypted.
   - Add backup expectations for dotfiles, mail, browser data, and keys.

5. UDisks2
   - Add USB/removable-drive workflow.
   - Decide between terminal-first mounting helpers and lightweight GUI affordances.
   - Document mount/unmount commands and required packages.

6. Polkit agent
   - Pick and autostart a Hyprland-compatible polkit agent.
   - Verify GUI authentication prompts appear reliably.

7. XDG and MIME defaults
   - Configure default applications for files, URLs, terminals, and handlers.
   - Verify `xdg-open` behavior from terminal apps and browsers.

8. Neomutt
   - Add mail stack design around `neomutt`, `isync`/`mbsync`, `msmtp`, `notmuch`, and GPG.
   - Keep secrets out of Git.
   - Document send/receive/indexing workflow.

9. Neovim follow-up
   - Done: align LazyVim with the Everforest system theme.
   - Done: enable LazyVim extras for Go, Node.js, JavaScript, TypeScript, Rust, C, and C++.
   - Decide whether development toolchains belong in `scripts/install-system` or remain documented manual installs.
