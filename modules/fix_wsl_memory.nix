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

  systemd.services.${name} = {
    script = "echo RUNNING && ${pkgs.python313} ${inputs.fix-wsl-memory}/drop_cache_if_idle";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
