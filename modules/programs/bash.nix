{ config, pkgs, primaryUser, ... }:

{
  home-manager.users.${primaryUser} = {
    home.packages = [
      pkgs.eza
      pkgs.bat
      pkgs.procs
      pkgs.htop
      pkgs.ripunzip
      pkgs.gum
      pkgs.zoxide
      pkgs.ripgrep
    ];

    programs.bash = {
      enable = true;
      enableCompletion = true;
      bashrcExtra = ''
        eval "$(zoxide init bash)"
      '';
      shellAliases = {
        cd = "z ";
        unzip = "ripunzip";
        grep = "rg";
        cat = "bat";
        ls = "exa";
        ps = "procs";
        tree = "ls --tree";
        rmzi = "rm -rf *Zone.Identifier";

        grepl = "rg -i 'warn\w*|fatal\w*|error\w*|e\d{3,4}|fail\w*'";
        greplp = "grepl --passthrough";
        grepp = "rg --passthrough";

        watch = "watch ";
        sudo = "sudo ";
      };
    };
  };
}
