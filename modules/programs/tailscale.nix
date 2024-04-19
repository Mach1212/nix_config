{ config, pkgs, primaryUser, ... }:

{
  services.tailscale = {
    enable = true;
  };

  specialisation.github.configuration = {
    services.tailscale = {
      extraUpFlags = [
        ""
      ];
    };
  };

}
