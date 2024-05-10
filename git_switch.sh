#!/bin/sh

if [[ -n $2 ]]; then
	specialization="--specialisation $2"
fi

echo Updating astro-config
nix flake lock --update-input astro-config || exit 1
echo Updating nix-config
nix flake lock --update-input nix-config || exit 1
git add '*' || exit 1
git diff-index --quiet HEAD || git commit -am "[Bot] Automated commit" || exit 1
echo hi ${@:2}
sudo nixos-rebuild switch --flake .#"$1" $specialization ${@:2} || exit 1
git push
