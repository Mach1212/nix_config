{
  config,
  pkgs,
  primaryUser,
  inputs,
  ...
}: {
  system.userActivationScripts.setup_nix_config.text = let
    path = "/home/${primaryUser}/nix_config";
  in ''
    mkdir -p ~/here2
    if [ ! -d ${path} ]; then
      mkdir -p ${path}
      cp -r ${inputs.nix-config} ${path}
    fi
  '';
}
