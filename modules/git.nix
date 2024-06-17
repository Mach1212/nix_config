{ config, pkgs, lib, primaryUser, auth, ... }:

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
        "mach12" = lib.mkMerge [
          {
            "mach12" = {
              userName = "Mach1212";
              userEmail = "maciej.pruchnik@gmail.com";
            };
            "work" = {
              userName = "Maciej-Pruchnik";
              userEmail = "maciej.pruchnik@ibm.com";
            };
          }."${auth}"
          {
            extraConfig = {
              credential = { helper = "store"; };
              branch = { autosetuprebase = "always"; };
            };
          }
        ];
        "nixos" = { };
      }."${primaryUser}"
    ];
    programs.bash = {
      bashrcExtra = ''
        source <(gh completion -s bash)
      '';
    };
  };
}
