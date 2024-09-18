{
  config,
  pkgs,
  primaryUser,
  ...
}: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  home-manager.users."${primaryUser}" = {
    home.packages = with pkgs; [
      podman
      podman-compose
    ];
  };
}
