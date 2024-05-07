{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.k3s
  ];
}
