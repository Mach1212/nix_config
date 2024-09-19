{
  config,
  pkgs,
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
  # environment.etc."sysctl.conf".text = ''
  #   net.ipv6.conf.all.disable_ipv6 = 1
  #   net.ipv6.conf.default.disable_ipv6 = 1
  #   net.ipv6.conf.lo.disable_ipv6 = 1
  # '';

  home-manager.users.${primaryUser} = {
    xdg.configFile."pip/pip.conf".text = ''
      [global]
      upgrade=true
      upgrade-strategy=only-if-needed
    '';

    programs.bash.bashrcExtra = ''
      export PYTHONPATH=$HOME/venv
      export PATH=$HOME/venv/bin:$PATH
    '';
  };

  system.userActivationScripts.setupPython = {
    text = ''
      cp -rL ${myPython} ~/venv
      chmod -R 777 ~/venv
      ${pkgs.ripgrep}/bin/rg -l '#!\/nix\/store\/\w*-\w*\/bin\/python' ~/venv | xargs -d '\n' sed -i "s|#!\/nix\/store\/\w*-\w*\/bin\/python|#!/home/$LOGNAME/venv/bin/python|g"
    '';
  };
}
