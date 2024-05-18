{ config, pkgs, primaryUser, ... }:

{
  home-manager.users.${primaryUser} = {
    home.packages = with pkgs; [
      ghidra
      burpsuite
      wireshark
      zap
      dirbuster
      sqlmap
      rustscan
      wpscan
      ssh-audit
    ];
    
    home.file.".rustscan.toml".text = ''
      range = { start = 1, end = 65535 }
      batch_size = 100
      tries = 5
    '';
  };
}
