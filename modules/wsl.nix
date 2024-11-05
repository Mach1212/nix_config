{
  config,
  pkgs,
  lib,
  primaryUser,
  ...
}: {
  imports = [
    ./fix_wsl_memory.nix
  ];

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
