{ config, pkgs, inputs, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    home.packages = [
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
  };
}
