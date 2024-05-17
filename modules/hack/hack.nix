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
    ];
  };
}
