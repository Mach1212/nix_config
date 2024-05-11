{ config, pkgs, primaryUser, ... }:

{
 imports = [
    ./sops.nix
  ];
  
  sops.secrets = {
    "ssh/id_rsa" = { 
      owner = primaryUser;
      path = "/home/${primaryUser}/.ssh/id_rsa";
    };
  };

  
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
}
