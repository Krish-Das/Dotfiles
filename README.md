## Versioning of the dotfiles

Here is an example tree-view of the structure of the dotfiles directory:

```bash
~/dotfiles
├── .git
│
├── home
│   ├── .config
│   │   └── zsh
│   └── .zshrc
└── nixos
    └── nixos
        ├── configuration.nix
        └── hardware-configuration.nix
```

### Version control of dotfiles

```bash
cd ~/dotfiles
stow -v -t "$HOME" home
```

The `-v` flag is for verbosity and `-t` specifies the target directory where the files should stow to. For instance, we want the _nixos_ directory to stow to `/etc` and the _home_ to the `$HOME` or `~`.

### Version control of nix config

I use [`gnu-stow`](https://search.nixos.org/packages?channel=24.11&show=stow&from=0&size=50&sort=relevance&type=packages&query=stow) instead of home-manager.

```bash
# Change ownership to avoid needing sudo for edits
sudo chown -R $USER:users ~/dotfiles/nixos

cd ~/dotfiles
sudo stow -v -t /etc nixos
```
