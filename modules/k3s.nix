{ pkgs, lib, config, ... }:

{
  services.k3s = {
    enable = true;
    role = "agent";
    serverAddr = "https://k8s.mpruchn.com:6443";
    token = builtins.readFile config.sops.secrets."tailscale".path;
    extraFlags = '''';
    
    package = pkgs.k3s.overrideAttrs (oldAttrs: {
      installPhase = ''
        makeWrapper ${pkgs.k3s}/bin/k3s $out/bin/k3s --prefix PATH : ${lib.makeBinPath [ pkgs.tailscale ]}
      '';
    });
  };

  sops = {
    "tailscale" = {
      restartUnits = ["k3s.service"];
    };
    "k3s/token-file" = {
      restartUnits = ["k3s.service"];
    };
    "k3s/vpn-auth-file" = {
      restartUnits = ["k3s.service"];
    };
  };
}
