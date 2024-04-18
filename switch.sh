#!/bin/sh

if [[ -z $1 ]]; then
	echo "Must select a configuration!"
	exit 1
fi

sudo chown -R mach12 .git &&
	sudo git add * &&
	(sudo nixos-rebuild switch --flake .#"$1" || exit 1) &&
	git commit -am "[Bot] Automated commit" &&
	git push
