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

  environment = {
    gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gnome-terminal
      # gedit # text editor
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

  

  home-manager.users."${primaryUser}" = let 
      deriv = stdenvNoCC.mkDerivation {
            pname = "Win11 Icons";
            version = "0.6";
            src = fetchGit {
              url = "https://github.com/yeyushengfan258/Win11-icon-theme";
              hash = "9c69f73b00fdaadab946d0466430a94c3e53ff68";
            };
            buildInputs = [ pkgs.bash ];
            installPhase = ''
              mkdir /home/${primaryUser}/here0
              patchShebangs install.sh
              ./install.sh
              mkdir /home/${primaryUser}/here1
            '';
          };
    in {
      gtk = {
        enable = true;
        iconTheme = {
          name = "win11-icon-theme-black";
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
        };
      };
      
      home.packages = [
        pkgs.microsoft-edge-dev
      ];
    };
  }
