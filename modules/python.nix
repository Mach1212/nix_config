{ config, pkgs, inputs, primaryUser, ... }:

{
  environment.etc = {
    "sysctl.conf" = {
      text = ''
        net.ipv6.conf.all.disable_ipv6 = 1 
        net.ipv6.conf.default.disable_ipv6 = 1
        net.ipv6.conf.lo.disable_ipv6 = 1
      '';
    };
  };

  home-manager.users."${primaryUser}" = {
    home.packages = [
      pkgs.black
      pkgs.isort
      (pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.pip
        python-pkgs.numpy
        python-pkgs.pandas
        python-pkgs.requests
        python-pkgs.matplotlib
        python-pkgs.seaborn
        python-pkgs.setuptools
      ]))
    ];


    home.file.".pip/pip.conf".text = ''
      [global]
      prefix=/home/${primaryUser}/.pip-global
    '';
    programs.bash = {
      bashrcExtra = ''
        export PATH=$HOME/.pip-global/bin:$PATH
        export PYTHONPATH='/home/${primaryUser}/.pip-global/lib/python3.11/site-packages/'
      '';
      shellAliases = {
        python = "python3";
      };
    };
  };
}
