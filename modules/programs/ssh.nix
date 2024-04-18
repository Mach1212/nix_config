{ config, pkgs, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    programs.ssh = {
      enable = true;
    };
  };
}
