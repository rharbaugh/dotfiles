I'm using GNU stow to restore these.

For example:

```
git clone https://github.com/rharbaugh/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow shared
```

You'll need to backup/remove any files these symlinks would overwrite.
