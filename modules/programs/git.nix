{ config, pkgs, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    home.packages = [
      pkgs.gh
    ];
    programs.git = {
      enable = true;
      userName = "Mach1212";
      userEmail = "maciej.pruchnik@gmail.com";
      extraConfig = {
        credential = { helper = "store"; };
        pull = { rebase = true; };
        rebase = { autoStash = true; };
        branch = { autosetuprebase = "always"; };
      };
    };
  };
}
