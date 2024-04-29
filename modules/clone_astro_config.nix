{ config, pkgs, primaryUser, inputs, ... }:

{
  system.userActivationScripts.setup_astro_config.text =
    let
      path = "~/.config/astro_config";
    in
    ''
      if [ ! -d ${path} ]; then
        cp -r ${inputs.astro-config} ${path}
        sudo chown -R ${primaryUser} ${path}
        chmod -R a-rwx ${path}
      fi
    '';
}
