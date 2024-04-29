{ config, pkgs, primaryUser, inputs, ... }:

{
  system.userActivationScripts.setup_astro_config.text =
    let
      path = "~/.config/astro_config";
    in
    ''
      if [ ! -d ${path} ]; then
        cp -r ${inputs.astro-config} ${path}
        sudo chmod -R u-rwx ${path}
      fi
    '';
}
