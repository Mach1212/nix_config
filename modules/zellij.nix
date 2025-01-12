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
            "unbind \"Ctrl g\" //" = "";
            "unbind \"Ctrl p\" //" = "";
            # "unbind \"Ctrl t\" //" = "";
            # "unbind \"Ctrl n\" //" = "";
            # "unbind \"Ctrl s\" //" = "";
            # "unbind \"Ctrl o\" //" = "";
            # "unbind \"Ctrl q\" //" = "";
            "unbind \"Ctrl h\" //" = "";
            "unbind \"Alt h\" //" = "";
            "unbind \"Alt l\" //" = "";
            "bind \"Alt g\"" = {SwitchToMode = "locked";};
            "bind \"Alt p\"" = {SwitchToMode = "pane";};
            "bind \"Alt j\"" = {MoveFocusOrTab = "Left";};
            "bind \"Alt k\"" = {MoveFocusOrTab = "Right";};
            "bind \"Alt h\"" = {SwitchToMode = "move";};
            # "bind \"Alt h\"" = {SwitchToMode = "move";};
            # "bind \"Alt t\"" = {SwitchToMode = "tab";};
            # "bind \"Alt s\"" = {SwitchToMode = "search";};
            # "bind \"Alt o\"" = {SwitchToMode = "session";};
            # "bind \"Alt q\" {Quit;} //" = "";
          };
          pane = {
            "unbind \"Ctrl p\" //" = "";
            "bind \"Alt p\"" = {SwitchToMode = "normal";};
          };
          locked = {
            "unbind \"Ctrl g\" //" = "";
            "bind \"Alt g\"" = {SwitchToMode = "normal";};
          };
        };
      };
    };
  };
}
