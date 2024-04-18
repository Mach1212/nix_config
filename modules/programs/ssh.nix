{ config, pkgs, primaryUser, ... }:

{
  services.sshd.enable = true;

  home-manager.users."${primaryUser}" = {
    programs.ssh = {
      enable = true;
      extraConfig = ''
        PasswordAuthentication no
        PubkeyAuthentication yes
      '';
    };
  };
}
