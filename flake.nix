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
        ];
        defaultModules = [
          home-manager.nixosModules.home-manager
          ./modules/users
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
            specialArgs = { inherit inputs; primaryUser = "mach12"; };
            system = "x86_64-linux";
            modules = defaultModules ++ wslModules ++ [
              ./hosts/default/configuration.nix
              ./modules/programs/rust.nix
            ];
          };
        laptop = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "mach12"; };
            system = "x86_64-linux";
            modules = defaultModules ++ wslModules ++ [
              nixos-wsl.nixosModules.wsl
              ./hosts/laptop/configuration.nix
              ./modules/programs/rust.nix
            ];
          };
      };
  };
}
