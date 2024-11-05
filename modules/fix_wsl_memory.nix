{
  inputs,
  pkgs,
  ...
}: let
  name = "fix_wsl_memory";
  frequency = "3m";
in {
  systemd.timers.${name} = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = frequency;
      OnUnitActiveSec = frequency;
      Unit = "${name}.service";
    };
  };

  systemd.services.${name} = let
    python = pkgs.python313.withPackages (pip: [
      pip.psutil
    ]);
  in {
    script = "echo RUNNING && ${python}/bin/python ${inputs.fix-wsl-memory}/drop_cache_if_idle";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
