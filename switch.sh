#!/bin/sh

if [[ -z $1 ]]; then
	echo "Must select a configuration!"
	exit 1
fi

specialization
if [[ -n $2 ]]; then
	specialization = "--specialisation $2"
fi

sudo chown -R $USER .git &&
	sudo git add * &&
	git commit -am "[Bot] Automated commit" &&
	(sudo nixos-rebuild switch --flake .#"$1" $specialization || exit 1) &&
	git push
