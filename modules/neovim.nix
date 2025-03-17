{
  config,
  pkgs,
  inputs,
  primaryUser,
  ...
}: {
  imports = [
    ./python.nix
  ];

  nixpkgs.overlays = [inputs.rust-overlay.overlays.default];
  home-manager.users."${primaryUser}" = {
    home.packages = with pkgs; [
      xdg-utils
      gcc
      libgcc
      wget
      unzip
      lazygit
      gitflow
      # (rust-bin.stable.latest.default.override {
      #   extensions = ["rust-std"];
      #   targets = ["wasm32-unknown-unknown"];
      # })
      (
        rust-bin.selectLatestNightlyWith (toolchain:
          toolchain.default.override {
            extensions = ["rust-src" "rust-std" "rustc-codegen-cranelift-preview" "rust-analyzer-preview" "rustfmt-preview"];
            targets = ["wasm32-unknown-unknown"];
          })
      )
      # poetry
      gum
      ripgrep
      nodejs_22
      yarn
      lua54Packages.luarocks-nix
      go
      php83Packages.composer
      jdk22
      gnumake
      shellcheck
      cmake
      lazydocker
      nixd
      tailwindcss
      alejandra
      deadnix
      statix
      sccache
      mold
      lld
      nodemon
    ];

    programs.firefox = {
      enable = true;
      profiles.selenium = {
        id = 0;
        name = "selenium";
        extensions = with config.nur.repos.rycee.firefox-addons; [
          darkreader
          dracula-dark-colorscheme
        ];
      };
    };

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

        musl-build() {
          if [ -n "$1" ]; then tag=":$1"; else tag=""; fi
          docker run \
            -v cargo-cache:/root/.cargo/registry \
            -v "$PWD:/volume" \
            --rm -it clux/muslrust$tag cargo build --release
        }

        npm set prefix $HOME/.npm-global

        export PATH=$HOME/.npm-global/bin:$PATH
        export PATH=$HOME/scripts:$PATH
        export PATH=/root/.cargo/bin:$PATH
        export NVIM_APPNAME=astro_config
        export RUSTC_WRAPPER=${pkgs.sccache}/bin/sccache
      '';
      shellAliases = {
        vi = "/home/mach12/projects/nixvim_config/result/bin/nvim";
        nvim = ''/home/mach12/projects/nixvim_config/result/bin/nvim --cmd "let g:auto_session_enabled = v:false"'';
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
