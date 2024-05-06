{ config, pkgs, primaryUser, ... }:

{
  home-manager.users.${primaryUser} = {
    home.packages = [
      pkgs.eza
      pkgs.bat
      pkgs.procs
      pkgs.htop
      pkgs.ripgrep
      pkgs.fd
    ];

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        cd = "z ";
        grep = "rg";
        find = "fd";
        cat = "bat";
        ls = "exa";
        ps = "procs";
        tree = "ls --tree";
        rmzi = "rm -rf *Zone.Identifier";

        grepl = "rg -i 'warn\w*|fatal\w*|error\w*|e\d{3,4}|fail\w*'";
        greplp = "grepl --passthrough";
        grepp = "rg --passthrough";
        grepmine= "rg '<[\w: ]+> |\[minecraft\/ServerGamePacketListenerImpl\]|\[minecraft\/PlayerList\]|\[minecraft\/DedicatedServer\]: \w+ joined|\[Server thread\/INFO\] \[minecraft\/DedicatedServer\]: \[[\w: ]+\]'";

        watch = "watch ";
        sudo = "sudo ";
      };
      initExtra =
        let complete_alias_path = builtins.fetchGit
          {
            url = "https://github.com/cykerway/complete-alias.git";
            rev = "7f2555c2fe7a1f248ed2d4301e46c8eebcbbc4e2";
          } + "/complete_alias";
        in
        builtins.readFile (complete_alias_path)
        +
        ''complete -F _complete_alias "''${!BASH_ALIASES[@]}"'';
    };
  };
}
