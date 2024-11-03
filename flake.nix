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
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nur.url = "github:nix-community/NUR";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-wsl,
    rust-overlay,
    nix-snapd,
    nixos-hardware,
    nur,
    ...
  } @ inputs: {
    nixosConfigurations = let
      base = [
        ./hosts/users.nix
        ./hosts/hostname.nix
        ./hosts/time.nix
      ];
      system =
        base
        ++ [
          home-manager.nixosModules.home-manager
          ./modules/home-manager.nix
          ./modules/bash.nix
          ./modules/git.nix
          ./modules/starship.nix
          # ./modules/auto_update.nix
          ./modules/clone_nix_config.nix
        ];
      wslModules = [
        nixos-wsl.nixosModules.wsl
        ./modules/wsl.nix
        ./hosts/wsl/configuration.nix
      ];
      devModules = [
        nur.nixosModules.nur
        ./modules/neovim.nix
        ./modules/zellij.nix
        ./modules/dynamic_linking.nix
        ./modules/podman.nix
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
        ./modules/fonts.nix
      ];
      kubeModules = [
        ./hosts/kube/configuration.nix
        ./modules/auto_login.nix
        ./modules/k3s.nix
        ./modules/ssh/mach12_pub.nix
      ];
      iso =
        system
        ++ sshModules
        ++ [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel.nix"
          "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
          ./hosts/iso/configuration.nix
        ];
      gameModules = [
        nix-snapd.nixosModules.default
        ./modules/mangohud.nix
        ./modules/snap.nix
        {
          programs.gamemode.enable = true;
        }
      ];
    in {
      mach12laptop =
        nixpkgs.lib.nixosSystem
        {
          specialArgs = {
            inherit inputs;
            primaryUser = "mach12";
            hostname = "laptop";
            auth = "mach12";
          };
          system = "x86_64-linux";
          modules =
            system
            ++ devModules
            ++ sshModules
            ++ guiModules
            ++ hackModules
            ++ gameModules
            ++ [
              ./hosts/mach12/configuration.nix
              nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd
              ./modules/kubernetes.nix
              ./modules/speedtest.nix
              ./modules/openvpn.nix
            ]
            ++ [
              ./modules/arduino.nix
              ({
                pkgs,
                primaryUser,
                ...
              }: {
                home-manager.users."${primaryUser}".programs.zellij.settings = {
                  copy_command = "wl-copy";
                };
              })
            ];
        };
      mach12wsl =
        nixpkgs.lib.nixosSystem
        {
          specialArgs = {
            inherit inputs;
            primaryUser = "mach12";
            hostname = "code";
            auth = "mach12";
          };
          system = "x86_64-linux";
          modules =
            system
            ++ wslModules
            ++ sshModules
            ++ devModules
            ++ [
              ./modules/kubernetes.nix
              ./modules/speedtest.nix
              ./modules/openvpn.nix
              ./modules/ollama.nix
              ({...}: {
                system.switch = {
                  enable = false;
                  enableNg = true;
                };
              })
            ];
        };
      mach12work =
        nixpkgs.lib.nixosSystem
        {
          specialArgs = {
            inherit inputs;
            primaryUser = "mach12";
            hostname = "work";
            auth = "work";
          };
          system = "x86_64-linux";
          modules =
            system
            ++ wslModules
            ++ devModules
            ++ [
              ./modules/ssh.nix
            ];
        };
    };
  };
}
