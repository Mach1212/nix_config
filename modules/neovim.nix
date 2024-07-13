{ config, pkgs, inputs, primaryUser, ... }:

{
  imports = [
    ./python.nix
    ./clone_astro_config.nix
  ];

  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
  home-manager.users."${primaryUser}" = {
    home.packages = [
      pkgs.gcc
      pkgs.wget
      pkgs.unzip
      pkgs.lazygit
      pkgs.gitflow
      (pkgs.rust-bin.stable.latest.default.override {
        extensions = [ "rust-std" ];
        targets = [ "wasm32-unknown-unknown" ];
      })
      # pkgs.poetry
      pkgs.gum
      pkgs.ripgrep
      pkgs.nodejs_22
      pkgs.lua54Packages.luarocks-nix
      pkgs.go
      pkgs.php83Packages.composer
      pkgs.jdk22
      pkgs.gnumake
      pkgs.shellcheck
      pkgs.cmake
      pkgs.lazydocker
    ];

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
        export PATH=$HOME/scripts:$PATH
        export NVIM_APPNAME=astro_config
      '';
      shellAliases = {
        docker = "sudo docker";
        dc = "docker compose";
        dk = "docker kill";
        dp = "docker ps";
        db = "docker build";
        dr = "docker run";
        await = ''function await_command() { sleeptime=5; if [[ -n $2 ]]; then sleeptime=$2; fi; until $1; do sleep $sleeptime; echo Attempting...; done; }; await_command'';

        st = "ssh_to.sh";
        cn = "kubectl config set-context --current --namespace";
        mkmvn = ''function make_maven_proj() { if [[ -z "$1" ]]; then printf "USAGE: mkmvn <PROJECT_NAME> <GROUP_ID>\n             PROJECT_NAME: awesome_app\n             GROUP_ID    : com.${primaryUser}.app"; return; fi; local GROUP_ID="$2"; if [[ -z "$2" ]]; then GROUP_ID=com.${primaryUser}.app; fi; mvn archetype:generate -DgroupId=$GROUP_ID -DartifactId=$1 -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false; }; make_maven_proj'';
        cmakeDev = "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1";
        genLLVMIR = "clang -S -emit-llvm";

        disasm = "objdump -zd";
      };
    };
  };
}
