{ config, pkgs, inputs, primaryUser, ... }:

{
  environment.etc."sysctl.conf".text = ''
    net.ipv6.conf.all.disable_ipv6 = 1 
    net.ipv6.conf.default.disable_ipv6 = 1
    net.ipv6.conf.lo.disable_ipv6 = 1
  '';

  home-manager.users."${primaryUser}" = {
    home.packages = [
      (pkgs.python312.withPackages (python-pkgs: with python-pkgs; [
        pip
        setuptools
        numpy
        pandas
        requests
        matplotlib
        seaborn
      ]))
    ];

    xdg.configFile."pip/pip.conf".text = ''
      [global]
      target=/home/${primaryUser}/.pip-global
      upgrade=true
      upgrade-strategy= only-if-needed
    '';

    programs.bash = {
      shellAliases = {
        python = "python3.12";
      };

      bashrcExtra = ''
        export PYTHONPATH=$HOME/.pip-global:$PYTHONPATH
        export PATH=$HOME/.pip-global/bin:$PATH
      '';
    };
  };
}
