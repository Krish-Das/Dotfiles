## Versioning of the dotfiles

Here is an example tree-view of the structure of the dotfiles directory:

```sh
~/dotfiles
├── .git
│
├── home
│   ├── .config
│   │   └── zsh
│   └── .zshrc
│
├── scripts/
│
└── nixos
    └── nixos
        ├── configuration.nix
        └── hardware-configuration.nix
```

### Version control of dotfiles

```sh
cd ~/dotfiles
stow -v -t "$HOME" home
```

The `-v` flag is for verbosity and `-t` specifies the target directory where the files should stow to. For instance, we want the _nixos_ directory to stow to `/etc` and the _home_ to the `$HOME` or `~`.

### Version control of nix config

I use [`gnu-stow`](https://search.nixos.org/packages?query=stow) instead of home-manager.

```sh
# Change ownership to avoid needing sudo for edits
sudo chown -R $USER:users ~/dotfiles/nixos

cd ~/dotfiles
sudo stow -v -t /etc nixos
```

### Stow the scripts

```sh
cd ~/dotfiles
stow -v -t "$HOME"/.local/bin scripts
```
