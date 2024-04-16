{ config, pkgs, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    programs.zellij = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        pane_frames = false;
      };
    };
  };
}
