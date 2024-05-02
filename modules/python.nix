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

    programs.bash = {
      shellAliases = {
        python = "python3";
        pip = "sudo pip";
      };

      bashrcExtra = ''
        export PIP_DOWNLOAD_CACHE=$HOME/.config/pip/cache
      '';
    };
  };
}
