{ pkgs, lib, primaryUser, stdenvNoCC,  ... }:

{
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
        });
      });
    })
  ];
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.sysprof.enable = true;
  
  services.xserver.excludePackages = [ pkgs.xterm ];

  environment = {
    gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      gedit # text editor
      xterm
    ]) ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);
    systemPackages = with pkgs; [
      gnome.adwaita-icon-theme
      sysprof
      gnomeExtensions.appindicator
      gnomeExtensions.gesture-improvements
      gnome.gnome-shell-extensions
      gnome.gnome-tweaks
      wl-clipboard
      betterdiscordctl
      vesktop
      evolution
      spotify
    ];
  };
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  

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

            nativeBuildInputs = [ pkgs.gtk4 ];

            installPhase = ''
              mkdir -p $out/share/themes/fluent-gtk-theme

              patchShebangs install.sh
              ./install.sh -ld $out/share/themes/fluent-gtk-theme
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

            nativeBuildInputs = [ pkgs.gtk3 ];

            installPhase = ''
              mkdir -p $out/share/icons

              patchShebangs install.sh
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
          "org/gnome/desktop/interface".color-scheme = "prefer-dark";
          "org/gnome/desktop/peripherals/mouse" = {
            speed = 1.0;
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
            ];
          };
          "org/gnome/desktop/wm/preferences" = {
            button-layout = "appmenu:minimize,maximize,close";
          };
        };
      };
      
      home.packages = [
        pkgs.microsoft-edge-dev
      ];
    };
  }
