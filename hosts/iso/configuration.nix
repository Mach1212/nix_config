{ pkgs, lib, primaryUser, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = lib.mkForce [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    gum
    (
      writeShellScriptBin "nix_installer"
        ''
          #!/usr/bin/env bash
          set -euo pipefail
          gsettings set org.gnome.desktop.session idle-delay 0
          gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

          if [ "$(id -u)" -eq 0 ]; then
          	echo "ERROR! $(basename "$0") should be run as a regular user"
          	exit 1
          fi

          if [ ! -d "$HOME/dotfiles/.git" ]; then
          	git clone https://gitlab.com/hmajid2301/dotfiles.git "$HOME/dotfiles"
          fi

          TARGET_HOST=$(ls -1 ~/dotfiles/hosts/*/configuration.nix | cut -d'/' -f6 | grep -v iso | gum choose)

          if [ ! -e "$HOME/dotfiles/hosts/$TARGET_HOST/disks.nix" ]; then
          	echo "ERROR! $(basename "$0") could not find the required $HOME/dotfiles/hosts/$TARGET_HOST/disks.nix"
          	exit 1
          fi

          gum confirm  --default=false \
          "🔥 🔥 🔥 WARNING!!!! This will ERASE ALL DATA on the disk $TARGET_HOST. Are you sure you want to continue?"

          echo "Partitioning Disks"
          sudo nix run github:nix-community/disko \
          --extra-experimental-features "nix-command flakes" \
          --no-write-lock-file \
          -- \
          --mode zap_create_mount \
          "$HOME/dotfiles/hosts/$TARGET_HOST/disks.nix"

          sudo nixos-install --flake "$HOME/dotfiles#$TARGET_HOST"
        ''
    )
  ];
}
}
