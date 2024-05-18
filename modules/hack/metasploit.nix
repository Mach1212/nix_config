{ config, pkgs, primaryUser, ... }:

{
  home-manager.users.${primaryUser} = {
    home.packages = with pkgs; [
      exploitdb
      metasploit
      armitage
    ];
  };
}
