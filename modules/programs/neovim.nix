{ config, pkgs, inputs, primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    home.packages = [
      pkgs.gcc
      pkgs.wget
      pkgs.unzip
      pkgs.lazygit
      pkgs.gitflow
      (pkgs.python3.withPackages (python-pkgs: [
        python-pkgs.pip
        python-pkgs.numpy
        python-pkgs.pandas
        python-pkgs.requests
        python-pkgs.seaborn
        python-pkgs.setuptools
      ]))
      pkgs.ripgrep
      pkgs.nodejs_21
      pkgs.lua54Packages.luarocks-nix
      pkgs.go
      pkgs.php83Packages.composer
      pkgs.jdk22
    ];

    home.file.".pip/pip.conf".text = ''
      [global]
      prefix=/home/${primaryUser}/.pip-global
    '';

    programs.bash = {
      bashrcExtra = ''
        npm set prefix $HOME/.npm-global
        
        export PATH=$HOME/.npm-global/bin:$PATH
        export PATH=$HOME/.pip-global/bin:$PATH
      '';
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
    xdg.configFile."nvim".source = builtins.fetchGit {
      url = "https://github.com/Mach1212/astro_config";
      rev = "bf28d19a876131295b75dde0a44bfa407164133a";
    };
  };
}
