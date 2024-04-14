{ config, pkgs, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
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
