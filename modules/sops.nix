{ pkgs, inputs, config, primaryUser, ... }:

{
  imports = [ inputs.sops-nix.nixosModules.sops ];
  
  home-manager.sharedModules = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  
  home-manager.users."${primaryUser}" = {
    home = {
      packages = [
        pkgs.sops
      ];
      file = {
        ".ssh/id_rsa".source = builtins.readFile config.sops.secrets."ssh/id_rsa".path;
        # ".secrets/tailscale".source = builtins.readFile config.sops.secrets."tailscale".path;
      };
    };

    sops = {
      defaultSopsFile = ../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";

      age.keyFile = "/home/${primaryUser}/.config/sops/age/keys.txt";
      # secrets = {
      #   "ssh/id_rsa" = { 
      #     owner = primaryUser;
      #   };
      #   "tailscale" = {
      #     owner = primaryUser;
      #   };
      # };
    };
  };
}
