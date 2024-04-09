{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations =
      let
        defaultModules = [
          inputs.home-manager.nixosModules.default
        ];
      in
      {

        default = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = defaultModules // [
            nixos-wsl.nixosModules.wsl
            ./hosts/default/configuration.nix
          ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = defaultModules // [
            nixos-wsl.nixosModules.wsl
            ./hosts/laptop/configuration.nix
          ];
        };
      };
  };
}
