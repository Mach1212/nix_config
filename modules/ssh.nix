{ config, pkgs, primaryUser, ... }:

{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  home-manager.users."${primaryUser}" = {
    home.file.".ssh/id_rsa".text = {
      "mach12" = builtins.readFile /run/secrets/ssh/id_rsa;
      "nixos" = ''Add SSH private key'';
    }."${primaryUser}";
  };
}
