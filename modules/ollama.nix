{
  config,
  pkgs,
  primaryUser,
  ...
}: {
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };
}
