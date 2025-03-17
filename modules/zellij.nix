{
  config,
  pkgs,
  primaryUser,
  ...
}: {
  # https://github.com/gmr458/.dotfiles/blob/main/zellij/.config/zellij/config.kdl
  home-manager.users."${primaryUser}" = {
    programs.zellij = {
      enable = true;
      settings = {
        pane_frames = false;
        "keybinds clear-defaults=true" = {
          normal = {};
          locked = {
            "bind \"Alt g\"" = {SwitchToMode = "Normal";};
          };
          resize = {
            "bind \"Alt n\"" = {SwitchToMode = "Normal";};
            "bind \"h\" \"Left\"" = {Resize = "Increase Left";};
            "bind \"j\" \"Down\"" = {Resize = "Increase Down";};
            "bind \"k\" \"Up\"" = {Resize = "Increase Up";};
            "bind \"l\" \"Right\"" = {Resize = "Increase Right";};
          };
          pane = {
            "bind \"Alt p\"" = {SwitchToMode = "Normal";};
            "bind \"h\"" = {MoveFocus = "Left";};
            "bind \"l\"" = {MoveFocus = "Right";};
            "bind \"j\"" = {MoveFocus = "Down";};
            "bind \"k\"" = {MoveFocus = "Up";};
            "bind \"c\"" = {"Clear //" = "";};
            "bind \"e\"" = {
              "TogglePaneEmbedOrFloating //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"f\"" = {
              "ToggleFocusFullscreen //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"j\" \"Down\"" = {
              NewPane = "Down";
              SwitchToMode = "Normal";
            };
            "bind \"i\" \"Right\"" = {
              NewPane = "Right";
              SwitchToMode = "Normal";
            };
            "bind \"n\"" = {
              "NewPane //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"p\"" = {
              "SwitchFocus //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"r\"" = {
              "PaneNameInput 0 //" = "";
              SwitchToMode = "RenamePane";
            };
            "bind \"w\"" = {
              "ToggleFloatingPanes //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"x\"" = {
              "CloseFocus //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"z\"" = {
              "TogglePaneFrames //" = "";
              SwitchToMode = "Normal";
            };
          };
          move = {
            "bind \"Alt m\"" = {SwitchToMode = "Normal";};
            "bind \"h\" \"Left\"" = {MovePane = "Left";};
            "bind \"j\" \"Down\"" = {MovePane = "Down";};
            "bind \"k\" \"Up\"" = {MovePane = "Up";};
            "bind \"l\" \"Right\"" = {MovePane = "Right";};
          };
          tab = {
            "bind \"Alt t\"" = {SwitchToMode = "Normal";};
            "bind \"b\"" = {
              "BreakPane //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"h\"" = {MoveTab = "Left";};
            "bind \"l\"" = {MoveTab = "Right";};
            "bind \"n\"" = {
              "NewTab //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"r\"" = {
              "TabNameInput 0 //" = "";
              SwitchToMode = "RenameTab";
            };
            "bind \"x\"" = {
              "CloseTab //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"1\"" = {
              "GoToTab 1 //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"2\"" = {
              "GoToTab 2 //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"3\"" = {
              "GoToTab 3 //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"4\"" = {
              "GoToTab 4 //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"5\"" = {
              "GoToTab 5 //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"6\"" = {
              "GoToTab 6 //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"7\"" = {
              "GoToTab 7 //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"8\"" = {
              "GoToTab 8 //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"9\"" = {
              "GoToTab 9 //" = "";
              SwitchToMode = "Normal";
            };
          };
          scroll = {
            "bind \"Alt s\"" = {SwitchToMode = "Normal";};
            "bind \"d\"" = {"HalfPageScrollDown //" = "";};
            "bind \"u\"" = {"HalfPageScrollUp //" = "";};
            "bind \"j\" \"Down\"" = {"ScrollDown //" = "";};
            "bind \"k\" \"Up\"" = {"ScrollUp //" = "";};
            "bind \"Home\"" = {
              "ScrollToTop //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"End\"" = {
              "ScrollToBottom //" = "";
              SwitchToMode = "Normal";
            };
            "bind \"PageDown\"" = {"PageScrollDown //" = "";};
            "bind \"PageUp\"" = {"PageScrollUp //" = "";};
            "bind \"s\"" = {
              "SearchInput 0 //" = "";
              SwitchToMode = "EnterSearch";
            };
          };
          search = {
            "bind \"Alt s\"" = {SwitchToMode = "Normal";};
            "bind \"n\"" = {Search = "down";};
            "bind \"p\"" = {Search = "up";};
            "bind \"c\"" = {SearchToggleOption = "CaseSensitivity";};
            "bind \"w\"" = {SearchToggleOption = "Wrap";};
            "bind \"o\"" = {SearchToggleOption = "WholeWord";};
          };
          entersearch = {
            "bind \"Alt c\" \"Esc\"" = {SwitchToMode = "Scroll";};
            "bind \"Enter\" " = {SwitchToMode = "Search";};
          };
          renametab = {
            "bind \"Alt c\"" = {SwitchToMode = "Normal";};
            "bind \"Enter\" " = {
              "UndoRenameTab //" = "";
              SwitchToMode = "Tab";
            };
          };
          renamepane = {
            "bind \"Alt c\"" = {SwitchToMode = "Normal";};
            "bind \"Enter\"" = {
              "UndoRenamePane //" = "";
              SwitchToMode = "Pane";
            };
          };
          session = {
            "bind \"Alt d\"" = {SwitchToMode = "Normal";};
            "bind \"d\"" = {"Detach //" = "";};
            "bind \"w\"" = {
              "LaunchOrFocusPlugin \"session-manager\"" = {
                floating = true;
                move_to_focused_tab = true;
              };
              SwitchToMode = "Normal";
            };
          };
          "shared_except \"locked\"" = {
            "bind \"Alt g\"" = {SwitchToMode = "Locked";};
            "bind \"Alt j\" \"Alt Down\"" = {"GoToPreviousTab //" = "";};
            "bind \"Alt k\" \"Alt Up\"" = {"GoToNextTab //" = "";};
            "bind \"Alt q\"" = {"Quit //" = "";};
            "bind \"Alt [\"" = {"PreviousSwapLayout //" = "";};
            "bind \"Alt ]\"" = {"NextSwapLayout //" = "";};
            "bind \"Alt i\"" = {"MoveTab \"Left\" //" = "";};
            "bind \"Alt o\"" = {"MoveTab \"Right\" //" = "";};
          };
          "shared_except \"normal\" \"locked\"" = {
            "bind \"Enter\" \"Esc\"" = {SwitchToMode = "Normal";};
          };
          "shared_except \"pane\" \"locked\"" = {
            "bind \"Alt p\"" = {SwitchToMode = "Pane";};
          };
          "shared_except \"resize\" \"locked\"" = {
            "bind \"Alt n\"" = {SwitchToMode = "Resize";};
          };
          "shared_except \"scroll\" \"locked\"" = {
            "bind \"Alt s\"" = {SwitchToMode = "Scroll";};
          };
          "shared_except \"session\" \"locked\"" = {
            "bind \"Alt d\"" = {SwitchToMode = "Session";};
          };
          "shared_except \"tab\" \"locked\"" = {
            "bind \"Alt t\"" = {SwitchToMode = "Tab";};
          };
          "shared_except \"move\" \"locked\"" = {
            "bind \"Alt m\"" = {SwitchToMode = "Move";};
          };
        };
        # plugins = {
        #   "compact-bar location=" = "zellij:compact-bar";
        # };
        # simplified_ui = true;
        # default_layout = "simple";
        copy_on_select = true;
      };
    };
  };
}
