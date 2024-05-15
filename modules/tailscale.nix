{ config, pkgs, primaryUser, ... }:

{
  imports = [
    ./sops.nix
  ];
  
  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets."tailscale".path;
  };
  
  sops.secrets = {
    "tailscale" = {
      owner = primaryUser;
      restartUnits = ["tailscaled.service"];
    };
  };
}
