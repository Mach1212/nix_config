{ config, pkgs, primaryUser, inputs, ... }:

{
  system.userActivationScripts.setup_astro_config.text =
    let
      path = "~/.config/astro_config";
    in
    ''
      if [ ! -d ${path} ]; then
        rm -rf ~/here*
        cp -r ${inputs.astro-config} ${path}
        # mkdir ~/here
        # sudo chown -R ${primaryUser} ${path}
        mkdir ~/here2
        sudo chmod -R 777 ${path}
        mkdir ~/here3
      fi
    '';
}
