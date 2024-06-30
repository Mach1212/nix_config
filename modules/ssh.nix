{ config, pkgs, primaryUser, auth, ... }:

{
  imports = [
    ./sops.nix
  ];

  sops.secrets = {
    "ssh/private/${auth}" = {
      owner = primaryUser;
      path = "/home/${primaryUser}/.ssh/id_rsa";
    };
    "ssh/public/${auth}" = {
      owner = primaryUser;
      path = "/home/${primaryUser}/.ssh/id_rsa.pub";
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
}
