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
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, rust-overlay, ... }@inputs: {
    nixosConfigurations =
      let
        wslModules = [
          nixos-wsl.nixosModules.wsl
          ./modules/programs/wsl.nix
          ./hosts/wsl/configuration.nix
        ];
        defaultModules = [
          home-manager.nixosModules.home-manager
          ./hosts/users.nix
          ./modules/programs/home-manager.nix
          ./modules/programs/bash.nix
          ./modules/programs/git.nix
          ./modules/programs/neovim.nix
          ./modules/programs/starship.nix
          ./modules/programs/zellij.nix
        ];
      in
      {
        default = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "nixos"; };
            system = "x86_64-linux";
            modules = defaultModules ++ [
              ({pkgs, ...}: {
                networking.hostName = "mach12nixos";
              })
            ];
          };
        mach12 = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "mach12"; };
            system = "x86_64-linux";
            modules = defaultModules ++ wslModules ++ [
              ({pkgs, ...}: {
                networking.hostName = "mach12laptop";
              })
              ./modules/programs/kubernetes.nix
              ./modules/programs/ssh.nix
            ];
          };
      };
  };
}
