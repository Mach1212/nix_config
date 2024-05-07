{ pkgs, lib, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;
}
