{ config, pkgs, inputs, primaryUser, ... }:

{
  environment.etc."sysctl.conf".text = ''
    net.ipv6.conf.all.disable_ipv6 = 1 
    net.ipv6.conf.default.disable_ipv6 = 1
    net.ipv6.conf.lo.disable_ipv6 = 1
  '';

  home-manager.users."${primaryUser}" = {
    home.packages = [
      (pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.pip
        python-pkgs.setuptools
        python-pkgs.numpy
        python-pkgs.pandas
        python-pkgs.requests
        python-pkgs.matplotlib
        python-pkgs.seaborn
      ]))
    ];


    home.file.".pip/pip.conf".text = ''
      [global]
      target=/home/${primaryUser}/.pip-global
    '';

    programs.bash = {
      shellAliases = {
        python = "python3";
      };

      bashrcExtra = ''
        export PYTHONPATH=$HOME/.pip-global
      '';
    };
  };
}
