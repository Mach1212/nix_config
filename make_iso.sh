#!/usr/bin/env bash

if [[ -z $1 ]]; then
	echo "Must select a configuration!"
	exit 1
fi

echo Updating astro-config
nix flake lock --update-input astro-config || exit 1
echo Updating nix-config
git add '*' || exit 1
git diff-index --quiet HEAD || git commit -am "[Bot] Automated commit" || exit 1
git push || exit 1
nix flake lock --update-input nix-config || exit 1

nix run nixpkgs#nixos-generators -- --format iso --flake .#"$1" -o result || exit

NIXPKGS_ALLOW_UNFREE=1 nix-shell -p qemu --run 'qemu-system-x86_64 -enable-kvm -m 256 -cdrom "./result/iso/$(ls result/iso)"'
