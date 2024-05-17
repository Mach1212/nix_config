{ config, pkgs, primaryUser, ... }:

{
  home-manager.users.${primaryUser} = {
    home.packages = with pkgs; [
      ghidra
      burpsuite
      nmap
      wireshark
    ];
  };
}
