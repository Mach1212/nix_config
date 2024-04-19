{ config, pkgs, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    home.packages = [
      pkgs.gh
    ];
    programs.git = {
      enable = true;
      extraConfig = {
        pull = { rebase = true; };
        rebase = { autoStash = true; };
      };
    };
  };
  home-manager.users."${primaryUser}" = {
    programs.git = {
      "mach12" = {
        userName = "Mach1212";
        userEmail = "maciej.pruchnik@gmail.com";
        extraConfig = {
          credential = { helper = "store"; };
          branch = { autosetuprebase = "always"; };
        };
      };
      "nixos" = { };
    }."${primaryUser}";
  };
}
