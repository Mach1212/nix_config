{ config, pkgs, primaryUser, inputs, ... }:

{
  system.userActivationScripts.setup_astro_config.text =
    let
      path = "~/.config/astro_config";
    in
    ''
      if [ ! -d ${path} ]; then
        cp -r ${inputs.astro-config} ${path}
        mkdir ~/here
        sudo chown -R ${primaryUser} ${path}
        mkdir ~/here2
        chmod -R a-rwx ${path}
        mkdir ~/here3
      fi
    '';
}
