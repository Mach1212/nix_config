{ config, pkgs, primaryUser, ... }:

{
  # services.sshd.enable = true;
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  # home-manager.users."${primaryUser}" = {
  #   programs.ssh = {
  #     enable = true;
  #     extraOptionOverrides = {
  #       PasswordAuthentication = "no";
  #       PubkeyAuthentication = "yes";
  #     };
  #   };
  # };
}
