{ pkgs, inputs, config, primaryUser, ... }:

{
  
  home-manager.users."${primaryUser}" = {
    imports = [ inputs.sops-nix.nixosModules.sops ];
  
    sops.defaultSopsFile = ../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";

    sops.age.keyFile = "/home/${primaryUser}/.config/sops/age/keys.txt";
    sops.secrets = {
      "ssh/id_rsa" = { 
        owner = "${primaryUser}";
      };
      "tailscale" = {
        owner = "${primaryUser}";
      };
    };

    home.packages = [
      pkgs.sops
    ];
    
    home.file.".ssh/id_rsa".source = builtins.readFile config.sops.secrets."ssh/id_rsa".path;
    home.file.".secrets/tailscale".source = builtins.readFile config.sops.secrets."tailscale".path;
  };
}
