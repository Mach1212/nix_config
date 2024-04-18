{ config, pkgs, primaryUser, ... }:

{
  services.sshd.enable = true;

  home-manager.users."${primaryUser}" = {
    programs.ssh = {
      enable = true;
      extraOptionOverrides = {
        PasswordAuthentication = "no";
        PubkeyAuthentication = "yes";
      };
    };
  };
}
