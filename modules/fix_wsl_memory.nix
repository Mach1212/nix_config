{inputs, ...}: let
  name = "fix_wsl_memory";
  frequency = "3m";
in {
  imports = [
    ./python.nix
  ];

  systemd.timers.${name} = {
    timerConfig = {
      OnBootSec = frequency;
      OnUnitActiveSec = frequency;
      Unit = "${name}.service";
    };
  };

  systemd.services.${name} = {
    script = "echo RUNNING && python ${inputs.fix-wsl-memory}/drop_cache_if_idle";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
