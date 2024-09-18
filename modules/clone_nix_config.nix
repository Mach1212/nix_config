{
  config,
  pkgs,
  primaryUser,
  inputs,
  ...
}: {
  system.userActivationScripts.setup_nix_config.text = let
    path = "~/nix_config";
  in ''
    if [ ! -d ${path} ]; then
      mkdir -p ${path}
      cp -r ${inputs.nix-config} ${path}
    fi
  '';
}
