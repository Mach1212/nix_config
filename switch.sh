#!/usr/bin/env bash

if [[ -n $2 ]]; then
	specialization="--specialisation $2"
fi

sudo nixos-rebuild switch --flake .#"$1" $specialization ${@:3} || exit 1
