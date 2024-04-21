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
    #   url = "github:Mach1212/k3s";
    #   flake = false;
    # };
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, rust-overlay, ... }@inputs: {
    nixosConfigurations =
      let
        system = [
          home-manager.nixosModules.home-manager
          ./hosts/users.nix
          ./hosts/hostname.nix
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
        sshModules = [
          ./modules/ssh.nix
          ./modules/tailscale.nix
        ];
        guiModules = [
          ./modules/gui.nix
        ];
      in
      {
        iso = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "mach12"; hostname = "booktop"; };
            system = "aarch64-linux";
            modules = system
              ++ [
              ./hosts/iso/configuration.nix
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
              ++ [
              ./modules/kubernetes.nix
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
