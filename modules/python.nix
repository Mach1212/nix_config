{ config, pkgs, inputs, primaryUser, ... }:

{
  environment.etc."sysctl.conf".text = ''
    net.ipv6.conf.all.disable_ipv6 = 1 
    net.ipv6.conf.default.disable_ipv6 = 1
    net.ipv6.conf.lo.disable_ipv6 = 1
  '';

  home-manager.users."${primaryUser}" = {
    home.packages = [
      (pkgs.python312.withPackages (python-pkgs: [
        python-pkgs.pip
        python-pkgs.setuptools
        python-pkgs.numpy
        python-pkgs.pandas
        python-pkgs.requests
        python-pkgs.matplotlib
        python-pkgs.seaborn
      ]))
    ];

    home.file.".config/pip/pip.conf".text = ''
      [global]
      target=/home/${primaryUser}/.pip-global
    '';

    programs.bash = {
      shellAliases = {
        python = "python3.12";
      };

      bashrcExtra = ''
        export PIP_DOWNLOAD_CACHE=$HOME/.pip-global/cache:$PIP_DOWNLOAD_CACHE
        export PYTHONPATH=$HOME/.pip-global:$PYTHONPATH
        export PATH=$HOME/.pip-global/bin:$PATH
      '';
    };
  };
}
