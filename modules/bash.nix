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
      pkgs.rcon
      pkgs.lm_sensors
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        get = "nix-shell -p";
        cd = "z ";
        grep = "rg";
        find = "fd";
        cat = "bat";
        ls = "exa";
        ps = "procs";
        tree = "ls --tree";
        rmzi = "rm -rf *Zone.Identifier";
        perfmon = ''watch -n.1 "sensors | rg 'CPU|PPT'"'';

        grepl = "rg -i 'warn\w*|fatal\w*|error\w*|e\d{3,4}|fail\w*'";
        greplp = "grepl --passthrough";
        grepp = "rg --passthrough";
        grepmine = ''rg "<[\w: ]+> |\[minecraft\/ServerGamePacketListenerImpl\]|\[minecraft\/PlayerList\]|\[minecraft\/DedicatedServer\]: \w+ joined|\[Server thread\/INFO\] \[minecraft\/DedicatedServer\]: \[[\w: ]+\]"'';

        watch = "watch ";
        sudo = "sudo ";
      };
      bashrcExtra = ''
        export PATH=$HOME/.cargo/bin:$PATH
        export EDITOR=nvim
      '';
      initExtra =
        let complete_alias_path = builtins.fetchGit
          {
            url = "https://github.com/cykerway/complete-alias.git";
            rev = "7f2555c2fe7a1f248ed2d4301e46c8eebcbbc4e2";
          } + "/complete_alias";
        in
        builtins.readFile (complete_alias_path)
        + ''complete -F _complete_alias "''${!BASH_ALIASES[@]}"'';
    };
  };
}
