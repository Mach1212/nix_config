{
  config,
  pkgs,
  primaryUser,
  inputs,
  ...
}: {
  system.userActivationScripts.setup_astro_config.text = let
    path = "/home/${primaryUser}/.config/astro_config";
  in ''
    mkdir -p ~/here3
    if [ ! -d ${path} ]; then
      mkdir -p ${path}
      cp -r ${inputs.astro-config}/* ${path}
      chmod -R 777 ${path}
    fi
  '';
}
