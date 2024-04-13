{ config, pkgs, ... }:

{ 
  home-manager.users."nixos" = {
    home.username = "nixos";
    home.homeDirectory = "/home/nixos";
  };
}
