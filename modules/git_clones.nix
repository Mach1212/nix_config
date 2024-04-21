{ config, pkgs, primaryUser, inputs, ... }:

{
  system.userActivationScripts.setup_clones.text = ''
    if [ ! -d ~/astro_config ]; then
      mkdir ~/here1
      echo '${inputs.astro-config}' >~/inputs
      cp ${inputs.astro-config} ~/.config/astro_config
    fi
    if [ -d ~/astro_config ]; then
      mkdir ~/here2
      echo '${inputs.astro-config}' >~/inputs
    fi
    mkdir ~/hi
  '';
}
