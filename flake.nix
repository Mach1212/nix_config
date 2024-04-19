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
        system = [
          home-manager.nixosModules.home-manager
          ./hosts/users.nix
          ./hosts/hostname.nix
          ./modules/home-manager.nix
          ./modules/bash.nix
          ./modules/git.nix
          ./modules/starship.nix
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
        ];
      in
      {
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
              ++ [
              # ./modules/gnome.nix
              ./modules/foliate.nix
            ];
          };
      };
  };
}
