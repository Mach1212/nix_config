{ config, pkgs, ... }:

{

  environment.systemPackages = [
    pkgs.neovim
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = builtins.fetchGit {
        url = "https://github.com/Mach1212/astro_config.git";
        ref = "main";
        rev = "commithash";
        allRefs = true;
      };
    };
  };
}
