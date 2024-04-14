{ config, pkgs, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    programs.zellij = {
      enable = true;
    };
  };
}
