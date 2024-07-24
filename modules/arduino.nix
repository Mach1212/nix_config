{ config, pkgs, primaryUser, ... }:

{

  users.users.${primaryUser}.extraGroups = [ "dialout" ];

  home-manager.users."${primaryUser}" = {
    home.packages = [
      pkgs.arduino-ide
    ];
  };
}
