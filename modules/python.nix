{
  config,
  pkgs,
  lib,
  inputs,
  primaryUser,
  ...
}: let
  myPython = pkgs.stdenvNoCC.mkDerivation {
    name = "myPython";

    phases = ["installPhase"];

    buildInputs = with pkgs; [
      python312Packages.virtualenv
    ];

    installPhase = ''
      virtualenv $out
    '';
  };
in {
  home-manager.users.${primaryUser} = {
    xdg.configFile."pip/pip.conf".text = ''
      [global]
      upgrade=true
      upgrade-strategy=only-if-needed
    '';

    programs.bash.bashrcExtra = let
      pythonldlibpath = lib.makeLibraryPath (with pkgs; [
        zlib
        zstd
        stdenv.cc.cc
        curl
        openssl
        attr
        libssh
        bzip2
        libxml2
        acl
        libsodium
        util-linux
        xz
        systemd
      ]);
    in ''
      export PYTHONPATH=$HOME/venv
      export PATH=$HOME/venv/bin:$PATH
      export LD_LIBRARY_PATH="${pythonldlibpath}"
    '';
  };

  system.userActivationScripts.setupPython.text = ''
    cp -rL ${myPython} /home/${primaryUser}/venv
    set +H
    ${pkgs.ripgrep}/bin/rg -l '#!\/nix\/store\/\w*-\w*\/bin\/python' /home/${primaryUser}/venv | xargs -d '\n' sed -i "s|#!\/nix\/store\/\w*-\w*\/bin\/python|#!$HOME/venv/bin/python|g"
  '';
}
