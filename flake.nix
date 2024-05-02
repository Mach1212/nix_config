{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    home-manager = {
      url = "github:nix-community/home-manager";
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
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, rust-overlay, ... }@inputs: {
    nixosConfigurations =
      let
        base = [
          ./hosts/users.nix
          ./hosts/hostname.nix
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
        ];
        sshModules = [
          ./modules/ssh.nix
          ./modules/tailscale.nix
        ];
        guiModules = [
          ./modules/gui.nix
        ];
        kubeModules = [
          ({ pkgs, ... }: {
            environment.systemPackages = [
              pkgs.k3s
            ];
          })
        ];
        iso = [
          ./hosts/iso/configuration.nix
        ];
      in
      {
        iso_x86 = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "nixos"; hostname = "nixos"; };
            system = "x86_64-linux";
            modules = iso
              ++ system
              ++ sshModules
              ++ kubeModules
              ++ [
            ];
          };
        kube_x86_worker = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "nixos"; hostname = "worker"; };
            system = "x86_64-linux";
            modules = iso
              ++ system
              ++ sshModules
              ++ kubeModules
              ++ [
            ];
          };
        kube_x86_master = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "nixos"; hostname = "master"; };
            system = "x86_64-linux";
            modules = iso
              ++ system
              ++ sshModules
              ++ kubeModules
              ++ [
            ];
          };
        mach12rpi = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "rpi"; hostname = "mach12rpi"; };
            system = "aarch64-linux";
            modules = system
              ++ [
            ];
          };
        wsl = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "nixos"; hostname = "wsl"; };
            system = "x86_64-linux";
            modules = system
              ++ wslModules
              ++ devModules
              ++ [
            ];
          };
        # linux = nixpkgs.lib.nixosSystem
        #   {
        #     specialArgs = { inherit inputs; primaryUser = "nixos"; hostname = "nixos"; };
        #     system = "x86_64-linux";
        #     modules = system
        #       ++ [
        #     ];
        #   };
        mach12laptop = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "mach12"; hostname = "laptop"; };
            system = "x86_64-linux";
            modules = system
              ++ wslModules
              ++ devModules
              ++ sshModules
              ++ hackModules
              ++ [
              ./modules/kubernetes.nix
              ./modules/dynamic_linking.nix
              # ./modules/clone_k3s.nix
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
