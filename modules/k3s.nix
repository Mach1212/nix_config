{ pkgs, lib, config, primaryUser, ... }:

{
  environment.systemPackages = [ pkgs.openiscsi ];
  
  imports = [
    ./sops.nix
  ];

  sops = {
    secrets = {
      "k3s/token-file" = {
        owner = primaryUser;
        restartUnits = ["k3s.service"];
      };
      "k3s/vpn-auth-file" = {
        owner = primaryUser;
        restartUnits = ["k3s.service"];
      };
    };
  };

  services.k3s = {
    enable = true;
    role = "agent";
    serverAddr = "https://k8s.mpruchn.com:6443";
    tokenFile = config.sops.secrets."k3s/token-file".path;
    extraFlags = ''
      --vpn-auth-file ${config.sops.secrets."k3s/vpn-auth-file".path}
    '';
    
    package = pkgs.k3s.overrideAttrs (oldAttrs: {
      installPhase = lib.replaceStrings 
        [ (lib.makeBinPath (oldAttrs.k3sRuntimeDeps)) ] 
        [ (lib.makeBinPath (oldAttrs.k3sRuntimeDeps ++ [ pkgs.tailscale ])) ]
        oldAttrs.installPhase;
    });
  };
}
