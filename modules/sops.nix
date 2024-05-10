{ pkgs, inputs, config, primaryUser, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/${primaryUser}/.config/sops/age/keys.txt";
    secrets = {
      "ssh/id_rsa" = { 
        owner = primaryUser;
        path = "/home/${primaryUser}/.ssh/id_rsa";
      };
      "tailscale" = {
        owner = primaryUser;
      };
    };
  };
  
  home-manager.sharedModules = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  
  home-manager.users."${primaryUser}" = {
    home = {
      packages = [
        pkgs.sops
      ];
    };
  };
}
