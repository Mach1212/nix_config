{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
    astro-config = {
      url = "github:Mach1212/astro_config";
      flake = false;
    };
    nix-config = {
      url = "github:Mach1212/nix_config";
      flake = false;
    };
    # k3s = {
    #   url = "git+ssh://git@github.com/Mach1212/k3s.git";
    #   flake = false;
    # };
    nix-snapd = {
      url = "github:nix-community/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, rust-overlay, nix-snapd, ... }@inputs: {
    nixosConfigurations =
      let
        base = [
          ./hosts/users.nix
          ./hosts/hostname.nix
          ./hosts/time.nix
        ];
        system = base ++ [
          home-manager.nixosModules.home-manager
          ./modules/home-manager.nix
          ./modules/bash.nix
          ./modules/git.nix
          ./modules/starship.nix
          ./modules/auto_update.nix
          ./modules/clone_nix_config.nix
        ];
        wslModules = [
          nixos-wsl.nixosModules.wsl
          ./modules/wsl.nix
          ./hosts/wsl/configuration.nix
        ];
        devModules = [
          ./modules/neovim.nix
          ./modules/zellij.nix
        ];
        hackModules = [
          ./modules/hack/aircrack-ng.nix
          ./modules/hack/hack.nix
          ./modules/hack/metasploit.nix
        ];
        sshModules = [
          ./modules/ssh.nix
          ./modules/tailscale.nix
        ];
        guiModules = [
          ./modules/gui.nix
        ];
        kubeModules = [
          ./hosts/kube/configuration.nix
          ./modules/auto_login.nix
          ./modules/k3s.nix
          ./modules/ssh/mach12_pub.nix
        ];
        iso = system
          ++ sshModules
          ++ [
          <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma5.nix>
          ./hosts/iso/configuration.nix
        ];
      in
      {
        amd64_iso = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "nixos"; hostname = "iso"; };
            system = "x86_64-linux";
            modules = iso;
          };
        arm64_iso = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "nixos"; hostname = "iso"; };
            system = "aarch64-linux";
            modules = iso;
          };
        amd64_kube_worker = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "nixos"; hostname = "worker"; };
            system = "x86_64-linux";
            modules = system
              ++ sshModules
              ++ kubeModules;
          };
        arm64_kube_worker = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "nixos"; hostname = "worker"; };
            system = "aarch64-linux";
            modules = system
              ++ sshModules
              ++ kubeModules;
          };
        arm64_kube_master = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "nixos"; hostname = "master"; };
            system = "aarch64-linux";
            modules = system
              ++ sshModules
              ++ kubeModules;
          };
        mach12rpi = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "rpi"; hostname = "mach12rpi"; };
            system = "aarch64-linux";
            modules = system;
          };
        wsl = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "nixos"; hostname = "wsl"; };
            system = "x86_64-linux";
            modules = system
              ++ wslModules
              ++ devModules;
          };
        mach12laptop = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "mach12"; hostname = "laptop"; };
            system = "x86_64-linux";
            modules = system
              ++ devModules
              ++ sshModules
              ++ guiModules
              ++ hackModules
              ++ [
              ./hosts/mach12/configuration.nix
              ./modules/kubernetes.nix
              ./modules/dynamic_linking.nix
              ./modules/speedtest.nix
              ./modules/openvpn.nix
            ] ++ [
              ./modules/arduino.nix
              nix-snapd.nixosModules.default
              {
                services.snap.enable = true;
              }
            ];
          };
        mach12wsl = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "mach12"; hostname = "wsl"; };
            system = "x86_64-linux";
            modules = system
              ++ wslModules
              ++ devModules
              ++ sshModules
              ++ [
              ./modules/kubernetes.nix
              ./modules/dynamic_linking.nix
            ];
          };
        mach12read = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "mach12"; hostname = "booktop"; };
            system = "x86_64-linux";
            modules = system
              ++ sshModules
              ++ guiModules
              ++ [
              ./modules/foliate.nix
            ];
          };
      };
  };
}
