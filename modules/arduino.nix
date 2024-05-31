{ config, pkgs, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    home.packages = [
      pkgs.arduino-ide
      (pkgs.python312.withPackages
        (python-pkgs: with python-pkgs; [
          pyserial
        ]))
    ];
  };


}
