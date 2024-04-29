#!/usr/bin/env bash

if [[ -z $1 ]]; then
	echo "Must select a configuration!"
	exit 1
fi

nix run nixpkgs#nixos-generators -- --format iso --flake .#"$1" -o result --system aarch64-linux
