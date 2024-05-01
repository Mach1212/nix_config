{ config, pkgs, primaryUser, inputs, ... }:

{
  system.userActivationScripts.setup_astro_config.text =
    let
      path = "~/k3s";
    in
    ''
      if [ ! -d ${path} ]; then
        cp -r ${inputs.k3s} ${path}
      fi
    '';
}
