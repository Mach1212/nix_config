{
  config,
  pkgs,
  primaryUser,
  inputs,
  ...
}: {
  system.userActivationScripts.setup_k3s_repo.text = let
    path = "/home/${primaryUser}/k3s";
  in ''
    if [ ! -d ${path} ]; then
      cp -r ${inputs.k3s} ${path}
    fi
  '';
}
