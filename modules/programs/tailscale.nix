{ config, pkgs, primaryUser, ... }:

{
  services.tailscale = {
    enable = true;
  };
}
