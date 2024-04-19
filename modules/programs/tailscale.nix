{ config, pkgs, primaryUser, ... }:

{
  services.tailscale = {
    enable = true;
  };

  specialisation.github.configuration = {
    hi = "hi";
  };

}
