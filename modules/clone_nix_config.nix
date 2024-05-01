{ config, pkgs, primaryUser, inputs, ... }:

{
  system.activationScripts.setup_astro_config.text =
    let
      path = "~/nix_config";
    in
    ''
      if [ ! -d ${path} ]; then
        cp -r ${inputs.nix-config} ${path}
      fi
    '';
}
