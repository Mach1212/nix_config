{
  config,
  pkgs,
  primaryUser,
  ...
}: {
  home-manager.users."${primaryUser}" = {
    programs.zellij = {
      enable = true;
      settings = {
        pane_frames = false;
        keybinds = {
          normal = {
            "bind \"Ctrl g\"" = {SwitchToMode = "locked";};
          };
        };
      };
    };
  };
}
