{
  config,
  pkgs,
  primaryUser,
  ...
}: {
  home-manager.users."${primaryUser}".home = {
    username = primaryUser;
    homeDirectory = "/home/${primaryUser}";
  };
}
