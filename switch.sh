#!/bin/sh

if [[ -n $2 ]]; then
	specialization="--specialisation $2"
fi

nix flake lock --update-input astro-config || exit 1
nix flake lock --update-input nix-config || exit 1
git add '*' || exit 1
git diff-index --quiet HEAD || git commit -am "[Bot] Automated commit" || exit 1
sudo nixos-rebuild switch --flake .#"$1" $specialization || exit 1
git push
