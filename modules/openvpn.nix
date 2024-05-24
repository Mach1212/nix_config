{ config, pkgs, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    home.packages = [
      pkgs.openvpn3
    ];
  };
}
