{ config, pkgs, primaryUser, ... }:

{
  home-manager.users.${primaryUser} = {
    home.packages = with pkgs; [
      aircrack-ng
      airgeddon
      hcxtools
      hcxdumptool
    ];
  };
}
