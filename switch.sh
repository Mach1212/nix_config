#!/bin/sh

if [[ -z $1 ]]; then
	echo "Must select a configuration!"
	exit 1
fi

sudo chown -R $USER .git &&
	sudo git add * &&
	git commit -am "[Bot] Automated commit" &&
	sudo git pull &&
	(sudo nixos-rebuild switch --flake .#"$1" || exit 1) &&
	git push
