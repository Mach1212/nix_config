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
            "bind \"Alt g\"" = {SwitchToMode = "locked";};
            "bind \"Alt p\"" = {SwitchToMode = "pane";};
            "bind \"Alt j\"" = {MoveFocusOrTab = "Left";};
            "bind \"Alt k\"" = {MoveFocusOrTab = "Right";};
          };
          locked = {
            "bind \"Alt g\"" = {SwitchToMode = "normal";};
          };
        };
      };
    };
  };
}
