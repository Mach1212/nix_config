#!/bin/sh

git add * \
  && (sudo nixos-rebuild switch --flake .#"$1" || (echo "Failed build" && exit 1)) \
	&& git commit -am "Automated commit" \
	&& git push
