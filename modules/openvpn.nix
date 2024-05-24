{ config, pkgs, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    home.packages = [
      pkgs.openvpn
      # pkgs.openvpn3
    ];
  };
}
