{ config, pkgs, primaryUser, ... }:

{
  virtualisation.docker.enable = true;

  users.users.${primaryUser}.extraGroups = [ "docker" ];

  home-manager.users."${primaryUser}" = {
    home.packages = [
      pkgs.docker
    ];
  };
}
