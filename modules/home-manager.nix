{
  config,
  pkgs,
  primaryUser,
  ...
}: {
  home-manager.users.mach12.home.stateVersion = "24.05";
  home-manager.users.asdf.home = {
    username = primaryUser;
    homeDirectory = "/home/${primaryUser}";
  };
}
