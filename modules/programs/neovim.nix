{ config, pkgs, inputs, primaryUser, ... }:

{
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
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
        python-pkgs.matplotlib
        python-pkgs.seaborn
        python-pkgs.setuptools
      ]))
      pkgs.rust-bin.stable.latest.default
      pkgs.poetry
      pkgs.gum
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
        if [[ -z "$ZELLIJ" ]]; then
        	if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
        		zellij attach -c
        	else
        		zellij a
        	fi

        	if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
        		exit
        	fi
        fi

        npm set prefix $HOME/.npm-global
        
        export PATH=$HOME/.npm-global/bin:$PATH
        export PATH=$HOME/.pip-global/bin:$PATH
        export PYTHONPATH='/home/${primaryUser}/.pip-global/lib/python3.11/site-packages/'
        export PATH=$HOME/scripts:$PATH
      '';
      shellAliases = {
        python = "python3";
        docker = "sudo docker";
        dc = "docker compose";
        dk = "docker kill";
        dp = "docker ps";
        db = "docker build";
        dr = "docker run";
        await = ''function await_command() { until $1; do sleep $2; echo Attempting...; done; }; await_command'';

        st = "ssh_to.sh";
        cn = "kubectl config set-context --current --namespace";
        mkmvn = ''function make_maven_proj() { if [[ -z "$1" ]]; then printf "USAGE: mkmvn <PROJECT_NAME> <GROUP_ID>\n             PROJECT_NAME: awesome_app\n             GROUP_ID    : com.mach12.app"; return; fi; local GROUP_ID="$2"; if [[ -z "$2" ]]; then GROUP_ID=com.mach12.app; fi; mvn archetype:generate -DgroupId=$GROUP_ID -DartifactId=$1 -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false; }; make_maven_proj'';
        cmakeDev = "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1";
        genLLVMIR = "clang -S -emit-llvm";

        disasm = "objdump -zd";
      };
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
      rev = "f3ccb0e7ff3bd4a590e7ae3496caacbe6b53b0d6";
    };
  };
}
