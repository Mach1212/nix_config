{ pkgs, lib, ... }:

{
  services.k3s.package = pkgs.k3s.overrideAttrs (oldAttrs: {
    installPhase = ''
      makeWrapper ${pkgs.k3s}/bin/k3s $out/bin/k3s --prefix PATH : ${lib.makeBinPath [ pkgs.tailscale ]}
    '';
  });
}
