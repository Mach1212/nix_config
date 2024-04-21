{ config, pkgs, primaryUser, inputs, ... }:

{
  system.userActivationScripts.setup_astro_config.text = ''
    if [ ! -d ~/astro_config ]; then
      cp -r ${inputs.astro-config} ~/.config/astro_config
    fi
  '';
}
