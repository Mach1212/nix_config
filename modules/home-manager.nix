{
  config,
  pkgs,
  primaryUser,
  ...
}: {
  home-manager.users.${primaryUser} = {
    home.username = primaryUser;
    home.homeDirectory = "/home/${primaryUser}";
  };
}
