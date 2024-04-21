{ config, pkgs, primaryUser, inputs, ... }:

{
  system.userActivationScripts.setup_nix_config.text = ''
    if [ ! -d ~/nix_config ]; then
      cp -r ${inputs.nix-config} ~/.config/astro_config
    fi
  '';
}
