{
  inputs,
  primaryUser,
  ...
}: let
  name = "fix_wsl_memory";
in {
  system.userActivationScripts.fix_wsl_memory.text = let
    path = "/home/${primaryUser}/${name}";
  in ''
    mkdir -p /home/${primaryUser}/here2
    if [ ! -d ${path} ]; then
      mkdir -p ${path}
      cp -r ${inputs.fix_wsl_memory} ${path}
    fi
  '';
}
