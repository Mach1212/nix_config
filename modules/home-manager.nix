{
  config,
  pkgs,
  primaryUser,
  ...
}: {
  home-manager.users.${primaryUser} = {
    home.stateVersion = "24.11";
    home.username = primaryUser;
    home.homeDirectory = "/home/${primaryUser}";
  };
}
