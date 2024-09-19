{
  config,
  pkgs,
  primaryUser,
  ...
}: {
  home-manager.users.${primaryUser} = {pkgs, ...}: {
    home.username = "${primaryUser}";
    home.homeDirectory = "/home/${primaryUser}";
    home.stateVersion = "24.05";
  };
}
