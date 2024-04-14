{ config, pkgs, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
