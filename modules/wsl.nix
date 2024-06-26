{ config, pkgs, lib, primaryUser, ... }:

{
  home-manager.users."${primaryUser}".home.packages = [
    pkgs.wslu
  ];

  wsl = {
    enable = true;
    defaultUser = "${primaryUser}";
    docker-desktop.enable = true;
    startMenuLaunchers = false;
    nativeSystemd = true;
    extraBin = with pkgs; [
      # Binaries for Docker Desktop wsl-distro-proxy
      { src = "${coreutils}/bin/mkdir"; }
      { src = "${coreutils}/bin/cat"; }
      { src = "${coreutils}/bin/whoami"; }
      { src = "${coreutils}/bin/ls"; }
      { src = "${busybox}/bin/addgroup"; }
      { src = "${su}/bin/groupadd"; }
      { src = "${su}/bin/usermod"; }
    ];
  };
}
