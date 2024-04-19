{ config, pkgs, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    home.packages = [
      pkgs.foliate
    ];
  };
}
