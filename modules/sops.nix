{ pkgs, inputs, primaryUser, ... }:

{
  imports = [ inputs.sops-nix.nixosModules.sops ];
  
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "~/.config/sops/age/keys.txt";
  sops.secrets."ssh/id_rsa" = { 
    owner = "${primaryUser}";
  };

  home-manager.users."${primaryUser}" = {
    home.file.".ssh/id_rsa".text = builtins.readFile /run/secrets/ssh/id_rsa;
    home.file.".secrets/tailscale".text = builtins.readFile /run/secrets/tailscale;
  };
}
