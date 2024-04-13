{ config, pkgs, ... }:

{

home-manager.users."nixos" = {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  xdg.configFile."nvim".source = builtins.fetchGit {
    url = "https://github.com/Mach1212/astro_config";
    rev = "bf28d19a876131295b75dde0a44bfa407164133a";
  };
};

}
