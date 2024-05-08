{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.k3s.overrideAttrs (finalAttrs: previousAttrs: {
      k3sRuntimeDeps = previousAttrs.k3sRuntimeDeps
        ++ [
          finalAttrs.tailscale
        ];
    })
  ];
  services.k3s.enable = true;
}
