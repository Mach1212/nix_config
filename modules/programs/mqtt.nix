{ config, pkgs, inputs, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    home.packages = [
      pkgs.mosquitto
    ];
  };
}
