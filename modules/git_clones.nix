{ config, pkgs, primaryUser, inputs, ... }:

{
  system.userActivationScripts.setup_clones.text = ''
    if [! -d "~/astro_config"]; then
      mkdir ~/wut
      echo '${inputs.astro-config}' >~/inputs
      cp ${inputs.astro-config} '~/.config/astro_config'
    fi
  '';
}
