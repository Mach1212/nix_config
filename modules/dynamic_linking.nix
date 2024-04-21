{ config, pkgs, lib, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [

    ];
  };
}
