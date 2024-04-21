#!/usr/bin/env bash

if [[ -z $1 ]]; then
	echo "Must select a configuration!"
	exit 1
fi

sudo nix run github:Mach1212/nix_config#nixosConfigurations.$1.config.system.build.tarballBuilder
