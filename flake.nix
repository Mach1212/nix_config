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
          ./hosts/hostname.nix
          ./modules/programs/home-manager.nix
          ./modules/programs/bash.nix
          ./modules/programs/git.nix
          ./modules/programs/neovim.nix
          ./modules/programs/starship.nix
          ./modules/programs/zellij.nix
        ];
        sshModules = [
          ./modules/programs/ssh.nix
          ./modules/programs/tailscale.nix
        ];
      in
      {
        wsl = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "nixos"; hostname = "wsl"; };
            system = "x86_64-linux";
            modules = defaultModules
              ++ wslModules
              ++ [
            ];
          };
        # linux = nixpkgs.lib.nixosSystem
        #   {
        #     specialArgs = { inherit inputs; primaryUser = "nixos"; hostname = "nixos"; };
        #     system = "x86_64-linux";
        #     modules = defaultModules
        #       ++ [
        #     ];
        #   };
        mach12laptop = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; primaryUser = "mach12"; hostname = "laptop"; };
            system = "x86_64-linux";
            modules = defaultModules
              ++ wslModules
              ++ sshModules
              ++ [
              ./modules/programs/kubernetes.nix
            ];
          };
      };
  };
}
