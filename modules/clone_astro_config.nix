{ config, pkgs, primaryUser, inputs, ... }:

{
  system.userActivationScripts.setup_astro_config.text =
    let
      path = "~/.config/astro_config";
    in
    ''
      if [ ! -d ${path} ]; then
        mkdir -p ${path}
        cp -r ${inputs.astro-config} ${path}
        chmod -R 777 ${path}
        rm -rf ~/.pip-global
      fi
    '';
}
