#!/usr/bin/env bash
set -e
pushd ~/dotfiles/nixos/nixos/
alejandra . &>/dev/null

git diff -U0 -- ./*.nix
echo "NixOS Rebuilding..."
sudo nixos-rebuild switch
popd
notify-send "Rebuild completed!"
