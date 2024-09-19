{
  config,
  pkgs,
  primaryUser,
  ...
}: {
  home-manager.users."${primaryUser}".home.stateVersion = "24.05";
  home-manager.users."${primaryUser}".home = {
    username = primaryUser;
    homeDirectory = "/home/${primaryUser}";
  };
}
