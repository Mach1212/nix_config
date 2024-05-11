{ pkgs, lib, config, ... }:

{
  services.k3s = {
    enable = true;
    role = "agent";
    serverAddr = "https://k8s.mpruchn.com:6443";
    tokenFile = config.sops.secrets."k3s/token-file".path;
    extraFlags = ''
      --vpn-auth-file ${config.sops.secrets."k3s/vpn-auth-file".path}
    '';
    
    package = pkgs.k3s.overrideAttrs (oldAttrs: {
      installPhase = ''
        # wildcard to match the arm64 build too
        install -m 0755 dist/artifacts/k3s* -D $out/bin/k3s
        wrapProgram $out/bin/k3s \
          --prefix PATH : ${lib.makeBinPath (oldAttrs.k3sRuntimeDeps ++ [ pkgs.tailscale ])} \
          --prefix PATH : "$out/bin"
        ln -s $out/bin/k3s $out/bin/kubectl
        ln -s $out/bin/k3s $out/bin/crictl
        ln -s $out/bin/k3s $out/bin/ctr
      '';
    });
  };
}
