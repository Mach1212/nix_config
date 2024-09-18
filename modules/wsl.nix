{
  config,
  pkgs,
  lib,
  primaryUser,
  ...
}: {
  home-manager.users."${primaryUser}".home.packages = [
    pkgs.wslu
  ];

  wsl = {
    enable = true;
    defaultUser = "${primaryUser}";
    startMenuLaunchers = false;
    nativeSystemd = true;
  };
}
