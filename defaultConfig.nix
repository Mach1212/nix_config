{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = [
    pkgs.nixfmt
  ];
}
