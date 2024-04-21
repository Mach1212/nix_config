{ config, pkgs, primaryUser, inputs, ... }:

{
  system.userActivationScripts.setup_clones.text = ''
    if [ ! -d ~/astro_config ]; then
      cp -r ${inputs.astro-config} ~/.config/astro_config
    fi
    if [ ! -d ~/nix_config ]; then
      cp -r ${inputs.nix-config} ~/.config/astro_config
    fi
  '';
}
