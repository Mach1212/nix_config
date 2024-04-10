{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.git
  ];

  programs.git = {
    enable = true;
    userName = "Mach1212";
    userEmail = "maciej.pruchnik@gmail.com";
  };
}
