{ config, pkgs, lib, primaryUser, ... }:

{
  system.autoUpgrade.enable = true;
  system.autoUpgrade.flake = "github:Mach1212/nix_config";
  system.autoUpgrade.flake = "github:Mach1212/astro_config";
  system.autoUpgrade.flags = [ "--update-input" "nixpkgs" "--commit-lock-file" "-L" ];
}
