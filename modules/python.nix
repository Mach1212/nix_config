{ config, pkgs, inputs, primaryUser, ... }:

{
  environment.etc."sysctl.conf".text = ''
    net.ipv6.conf.all.disable_ipv6 = 1 
    net.ipv6.conf.default.disable_ipv6 = 1
    net.ipv6.conf.lo.disable_ipv6 = 1
  '';

  home-manager.users."${primaryUser}" = {
    home.packages = [

      (pkgs.python313.withPackages (python-pkgs: [
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
      # prefix=/home/${primaryUser}/.python
    '';

    programs.bash = {
      shellAliases = {
        python = "python3.13";
      };

      bashrcExtra = ''
        export PIP_DOWNLOAD_CACHE=$HOME/.config/pip/cache:$PIP_DOWNLOAD_CACHE
        # export PYTHONPATH=$HOME/.python/lib/python3.13/site-packages:$PYTHONPATH
        # export PATH=$HOME/.python/bin:$PATH
      '';
    };
  };
}
