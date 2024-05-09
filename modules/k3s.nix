{ pkgs, lib, ... }:

{
  environment.systemPackages = [
    pkgs.k3s
  ];

  services.k3s.package = pkgs.k3s.overrideAttrs (oldAttrs: {
    installPhase = ''
      makeWrapper ${pkgs.k3s}/bin/k3s $out/bin/k3s --prefix PATH : ${lib.makeBinPath [ pkgs.tailscale ]}
    '';
  });
  "mach12" = builtins.readFile /run/secrets/ssh/id_rsa;
}
