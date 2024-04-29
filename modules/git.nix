{ config, pkgs, lib, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    home.packages = [
      pkgs.gh
    ];
    programs.git = lib.mkMerge [
      {
        enable = true;
        extraConfig = {
          pull = { rebase = true; };
          rebase = { autoStash = true; };
        };
      }
      {
        "mach12" = {
          userName = "Mach1212";
          userEmail = "maciej.pruchnik@gmail.com";
          extraConfig = {
            credential = { helper = "store"; };
            branch = { autosetuprebase = "always"; };
          };
        };
        "nixos" = { };
      }."${primaryUser}"
    ];
    programs.bash = {
      bashrcExtra = ''
        eval "$(gh completion -s bash)"
      '';
    };
  };
}
