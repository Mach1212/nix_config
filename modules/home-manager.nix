{
  config,
  pkgs,
  primaryUser,
  ...
}: {
  home-manager.users.asdf.home = {
    username = primaryUser;
    homeDirectory = "/home/${primaryUser}";
    stateVersion = "24.11";
  };
}
