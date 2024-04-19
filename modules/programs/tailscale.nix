{ config, pkgs, primaryUser, ... }:

{
  services.tailscale = {
    enable = true;
    specialization."github".configuration = {
      hi = hi;
    };
  };

}
