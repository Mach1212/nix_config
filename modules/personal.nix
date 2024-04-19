{ config, pkgs, primaryUser, ... }:

{

  home-manager.users.${primaryUser} = {
    programs.bash = {
      bashrcExtra = ''
        export NVIM_APPNAME=astro_config
      '';
    };
  };
  system.userActivationScripts.personalSetup.text = ''
    git clone https://github.com/Mach1212/nix_config.git ~/nix_config
    git clone https://github.com/Mach1212/astro_config.git ~/.config/astro_config
    git clone https://github.com/Mach1212/scripts.git ~/scripts
    mkdir -p ~/clones ~/projects
  '';
}
