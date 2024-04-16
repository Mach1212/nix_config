#!/bin/sh

if [[ -z $1 ]]; then
	echo "Must select a configuration!"
	exit 1
fi

sudo git add * &&
	(sudo nixos-rebuild switch --flake .#"$1" || (echo "Failed build" && exit 1)) &&
	sudo git commit -am "[Bot] Automated commit" &&
	sudo git push
