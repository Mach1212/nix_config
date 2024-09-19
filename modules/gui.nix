{
  pkgs,
  lib,
  primaryUser,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
        mutter = gnomePrev.mutter.overrideAttrs (old: {
          src = pkgs.fetchgit {
            url = "https://gitlab.gnome.org/vanvugt/mutter.git";
            # GNOME 45: triple-buffering-v4-45
            rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
            sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
          };
          nativeBuildInputs = old.nativeBuildInputs ++ [pkgs.cmake];
        });
      });
    })
  ];

  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [pkgs.xterm];
  };

  services.sysprof.enable = true;

  environment = {
    gnome.excludePackages =
      (with pkgs; [
        gnome-photos
        gnome-tour
        gedit # text editor
        xterm
      ])
      ++ (with pkgs.gnome; [
        # gnome-shell-extensions
        # cheese # webcam tool
        gnome-music
        epiphany # web browser
        # geary # email reader
        evince # document viewer
        gnome-characters
        totem # video player
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
      ]);
    systemPackages = with pkgs; [
      sassc
      gnome-menus
      sysprof
      wl-clipboard
      gnome.adwaita-icon-theme
      gnome.gnome-terminal
      gnome-extension-manager
      gnome.gnome-shell
      gnome.gnome-tweaks
      gnome.gnome-themes-extra
      gnomeExtensions.appindicator
      (gnomeExtensions.gesture-improvements.overrideAttrs (oldAttrs: {
        src = fetchzip {
          url = "https://github.com/harshadgavali/gnome-gesture-improvements/files/12841762/gestureImprovements%40gestures.zip";
          hash = "sha256-8I1uQOEjIwIg2WCxYxlVj2I025/L209K5gg2NPSV5Qo=";
        };
      }))
      gnomeExtensions.dash-to-panel
      gnomeExtensions.arcmenu
      gnomeExtensions.blur-my-shell
      gnomeExtensions.date-menu-formatter
      gnomeExtensions.media-controls
      gnomeExtensions.gtk4-desktop-icons-ng-ding
      gnomeExtensions.clipboard-history
      gnomeExtensions.gsconnect
    ];
  };

  services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["AurulentSansMono"];})
  ];

  home-manager.users."${primaryUser}" = {
    gtk = {
      enable = true;
      theme = {
        name = "Fluent-Dark";
        # name = "Fluent-Light";
        package = pkgs.stdenvNoCC.mkDerivation {
          pname = "fluent-gtk-theme";
          version = "2024-04-28-unstable-2024-05-14";
          name = "win11";

          src = pkgs.fetchFromGitHub {
            owner = "vinceliuice";
            repo = "fluent-gtk-theme";
            rev = "755f3ed0ce5bdfa87a733cda48ab8402b9b6c2ad";
            hash = "sha256-I/U+ebpRM0sXZchs/viRmfX1ZeJgei41ax/dlcDWxu8=";
          };

          nativeBuildInputs = [
            pkgs.gtk4
            pkgs.gnome.gnome-shell
          ];

          buildInputs = [
            pkgs.gnome.gnome-themes-extra
            pkgs.sassc
          ];

          installPhase = ''
            mkdir -p $out/share/themes

            patchShebangs install.sh
            ./install.sh -l -d $out/share/themes
          '';

          meta = with lib; {
            description = "Fluent is a Fluent design theme for GNOME/GTK based desktop environments. See also Fluent Icon theme.";
            homepage = "https://github.com/vinceliuice/fluent-gtk-theme";
            license = licenses.gpl3Only;
            mainProgram = "fluent-gtk-theme";
            platforms = platforms.all;
          };
        };
      };
      iconTheme = {
        name = "win11-blue";
        package = pkgs.stdenvNoCC.mkDerivation {
          pname = "win11-icon-theme";
          version = "0-unstable-2023-05-13";
          name = "win11";

          src = pkgs.fetchFromGitHub {
            owner = "yeyushengfan258";
            repo = "Win11-icon-theme";
            rev = "9c69f73b00fdaadab946d0466430a94c3e53ff68";
            hash = "sha256-jN55je9BPHNZi5+t3IoJoslAzphngYFbbYIbG/d7NeU=";
          };

          nativeBuildInputs = [pkgs.gtk3];

          installPhase = ''
            mkdir -p $out/share/icons

            patchShebangs install.sh

            if [ -d /home/mach12/.config/gtk-4.0/settings.ini ]; then
              echo Removing gtk-4.0/setings.ini
              rm /home/${primaryUser}/.config/gtk-4.0/settings.ini
            fi

            if [ -d /home/mach12/.config/gtk-3.0/settings.ini ]; then
              echo Removing gtk-3.0/setings.ini
              rm /home/${primaryUser}/.config/gtk-3.0/settings.ini
            fi

            ./install.sh -a -d $out/share/icons
          '';

          meta = with lib; {
            description = "A colorful design icon theme for linux desktops";
            homepage = "https://github.com/yeyushengfan258/Win11-icon-theme";
            license = licenses.gpl3Only;
            mainProgram = "win11-icon-theme";
            platforms = platforms.all;
          };
        };
      };
    };
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
        "org/gnome/desktop/peripherals/mouse" = {
          speed = 0.0;
          accel-profile = "flat";
        };
        "org/gnome/desktop/peripherals/touchpad" = {
          speed = 0.215;
          tap-to-click = true;
        };
        "org/gnome/shell" = {
          disabled-extensions = [];
          enabled-extensions = [
            "user-theme@gnome-shell-extensions.gcampax.github.com"
            "drive-menu@gnome-shell-extensions.gcampax.github.com"
            "dash-to-panel@jderose9.github.com"
            "date-menu-formatter@marcinjakubowski.github.com"
            "gtk4-ding@smedius.gitlab.com"
            "arcmenu@arcmenu.com"
            "blur-my-shell@aunetx"
            "mediacontrols@cliffniff.github.com"
            "gestureImprovements@gestures"
            "clipboard-history@alexsaveau.dev"
            "gsconnect@andyholmes.github.io"
          ];
        };
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";
        };
        "org/gnome/shell/extensions/user-theme" = {
          name = "Fluent-Dark";
        };
        "org/gnome/desktop/background" = {
          picture-uri = "file:///home/${primaryUser}/.config/background-light.jpg";
          picture-options = "zoom";
          picture-uri-dark = "file:///home/${primaryUser}/.config/background-dark.jpg";
        };
        # "org/gnome/desktop/screensaver" = {
        #   picture-uri = "";
        # };
        "org/gnome/shell/extensions/gtk4-ding" = {
          icon-size = "small";
          show-network-volumes = true;
        };
        "org/gnome/shell/extensions/dash-to-panel" = {
          panel-element-positions = ''{"0":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}],"1":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}],"2":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}'';
          appicon-margin = 0;
          appicon-padding = 6;
          dot-style-focused = "DASHES";
          dot-style-unfocused = "DASHES";
          hide-overview-on-startup = true;
          tray-size = 16;
          leftbox-size = 16;
          tray-padding = 4;
          status-icon-padding = 4;
          leftbox-padding = 4;
          animate-appicon-hover = true;
          # click-action = "LAUNCH";
        };
        "org/gnome/shell/extensions/arcmenu" = {
          menu-layout = "Eleven";
          menu-height = 750;
          left-panel-width = 175;
          menu-item-icon-size = "Medium";
          custom-menu-button-icon = "/home/${primaryUser}/.config/windows-icon.png";
          alphabetize-all-programs = false;
        };
        "org/gnome/shell/extensions/blur-my-shell/panel" = {
          override-background = false;
          customize = true;
          sigma = 10;
        };
        "org/gnome/shell/extensions/date-menu-formatter" = {
          text-align = "center";
          pattern = ''MM/dd/yy\nHH : mm a'';
          update-level = 0;
        };
        "gnome/shell/extensions/mediacontrols" = {
          show-controls-icons = false;
          show-label = false;
        };
        "org/gnome/settings-daemon/plugins/color" = {
          night-light-schedule-to = 3.5;
          night-light-schedule-from = 22.0;
          night-light-enabled = true;
          night-light-temperature = 2362;
        };
        "org/gnome/mutter" = {
          experimental-features = ["scale-monitor-framebuffer"];
        };
        "org/gnome/Console" = {
          use-system-font = false;
          custom-font = "AurulentSansM Nerd Font Mono 10";
        };
        "org/gnome/shell" = {
          favorite-apps = ["org.gnome.Nautilus.desktop" "microsoft-edge-beta.desktop" "org.gnome.Terminal.desktop" "vesktop.desktop" "org.gnome.Geary.desktop"];
        };
        "org/gnome/nautilus/preferences" = {
          default-folder-viewer = "list-view";
        };
        "org/gnome/desktop/interface" = {
          show-battery-percentage = true;
        };
        # "org/gnome/shell/extensions/gestureImprovements" = {
        #   default-overview = true;
        #   default-session-workspace = true;
        # };
        "com/mattjakeman/ExtensionManager" = {
          sort-enabled-first = true;
        };
        "org/gnome/shell/keybindings" = {
          show-screenshot-ui = ["<Shift><Super>s"];
          switch-applications = [];
          switch-applications-backwards = [];
          switch-windows = ''<Alt>Tab'';
          switch-windows-backward = ''<Shift><Alt>Tab'';
        };
        "org/gnome/shell/extensions/gsconnect/device/2eb7dc7a_46ab_441f_9a89_c41dc32ab8d0/plugin/telephony" = {
          ringing-pause = true;
        };
      };
    };

    home.packages = [
      pkgs.microsoft-edge-beta
      pkgs.betterdiscordctl
      pkgs.vesktop
      pkgs.spotify
      pkgs.arduino-ide
      # (pkgs.badlion-client.overrideAttrs
      #   (old: {
      #     src = pkgs.fetchurl {
      #       url = "https://client-updates-cdn77.badlion.net/BadlionClient";
      #       hash = "sha256-9elNLSqCO21m1T2D+WABKotD9FfW3FrcOxbnPdyVd+w=";
      #     };
      #   }))
      pkgs.lunar-client
    ];

    home.file.".config/background-light.jpg".source = pkgs.fetchurl {
      url = "https://4kwallpapers.com/images/wallpapers/windows-11-blue-stock-white-background-light-official-3840x2400-5616.jpg";
      hash = "sha256-o3SRpeR54ZHP5Ue0hEJgN0Vc6KrP96sV+RklMwwkhk8=";
    };
    home.file.".config/background-dark.jpg".source = pkgs.fetchurl {
      url = "https://4kwallpapers.com/images/wallpapers/windows-11-dark-mode-blue-stock-official-3840x2400-5630.jpg";
      hash = "sha256-1UJiAyV0sVzPVB5A+hNHX/s52GgsGTg+kX8+1ei7ynE=";
    };
    home.file.".config/windows-icon.png".source = pkgs.fetchurl {
      url = "https://drive.usercontent.google.com/uc?id=1oevGvxjvQzwtgn00sbB8_kTyQ8ZGkAYn&authuser=0&export=download";
      hash = "sha256-FDAOGpX9oiS18xEYbEyfEft9kbFCbRncBaHoIJ5qV3c=";
    };
  };

  services.logind = {
    lidSwitchDocked = "suspend";
  };

  networking.firewall.allowedTCPPortRanges = [
    # KDE Connect
    {
      from = 1714;
      to = 1764;
    }
  ];
  networking.firewall.allowedUDPPortRanges = [
    # KDE Connect
    {
      from = 1714;
      to = 1764;
    }
  ];
}
