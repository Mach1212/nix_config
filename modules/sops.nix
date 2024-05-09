{ pkgs, inputs, config, primaryUser, ... }:

{
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

  home-manager.users."${primaryUser}" = {
    home.file.".ssh/id_rsa".text = ''${config.sops.secrets."ssh/id_rsa"}'';
    home.file.".secrets/tailscale".text = ''${config.sops.secrets."tailscale"}'';
  };
}
