{ config, pkgs, lib, inputs, primaryUser, ... }:

{
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--update-input"
      "nixos-wsl"
      "--update-input"
      "home-manager"
      "--update-input"
      "sops-nix "
      "--update-input"
      "rust-overlay"
      "--update-input"
      "astro-config"
      "--update-input"
      "nix-config "
      "--update-input"
      "nix-snapd"
      "--update-input"
      "nixos-hardware"
      "--commit-lock-file"
      "-L"
    ];
  };
}
