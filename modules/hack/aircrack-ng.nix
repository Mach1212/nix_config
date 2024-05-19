{ config, pkgs, primaryUser, ... }:

{
  home-manager.users.${primaryUser} = {
    home.packages = with pkgs; [
      aircrack-ng
      wifite2
      bettercap
    ];
  };
}
