{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, ... }@inputs: {
    nixosConfigurations =
      let
        defaultModules = [
          ./defaultConfig.nix
          inputs.home-manager.nixosModules.home-manager
          ./modules/home-manager.nix
          inputs.nixvim.nixosModules.nixvim
          ./modules/nixvim.nix
        ];
      in
      {
        default = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; };
            system = "x86_64-linux";
            modules = defaultModules ++ [
              nixos-wsl.nixosModules.wsl
              ./hosts/default/configuration.nix
            ];
          };
        laptop = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; };
            system = "x86_64-linux";
            modules = defaultModules ++ [
              nixos-wsl.nixosModules.wsl
              ./hosts/laptop/configuration.nix
            ];
          };
      };
  };
}
