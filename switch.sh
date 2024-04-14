#!/bin/sh

sudo git add * \
  && (sudo nixos-rebuild switch --flake .#"$1" || (echo "Failed build" && exit 1)) \
	&& git commit -am "[Bot] Automated commit" \
	&& git push
