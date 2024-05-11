#!/bin/sh

echo Updating astro-config
nix flake lock --update-input astro-config || exit 1
echo Updating nix-config
nix flake lock --update-input nix-config || exit 1
git add '*' || exit 1
git diff-index --quiet HEAD || git commit -am "[Bot] Automated commit" || exit 1
sudo nixos-rebuild switch --flake .#${@:1} || exit 1
git push
