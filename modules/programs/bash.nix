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
    ];

    programs.bash = {
      enable = true;
      enableCompletion = true;
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

        eval "$(starship init bash)"
        eval "$(zoxide init bash)"

        export PATH=$HOME/scripts:$PATH
      '';
      shellAliases = {
        cd = "z ";
        unzip = "ripunzip";
        grep = "rg";
        cat = "bat";
        ls = "exa";
        ps = "procs";
        python = "python3";
        tree = "ls --tree";
        rmzi = "rm -rf *Zone.Identifier";
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
        grepl = "rg -i 'warn\w*|fatal\w*|error\w*|e\d{3,4}|fail\w*'";
        greplp = "grepl --passthrough";
        grepp = "rg --passthrough";

        watch = "watch ";
        sudo = "sudo ";

        ic = "istioctl";
        kc = "kubectl";
        kg = "kc get";
        ka = "kc apply";
        kaf = "ka -f";
        kr = ''function make_pod() { kc run "$1" --image "$2" "''${@:3}"; }; make_pod'';
        krOn = "krOn.sh";
        kd = "kc delete";
        kdf = "kd -f";
        kl = "kc logs";
        klf = "kc logs --follow";
        ke = "kc edit";
        kDbg = ''function debug_faulty_pod() {  kc debug "$1" --image=ubuntu --share-processes --copy-to debug-"$1" -it -- sh && kd pod/debug-"$1"; }; debug_faulty_pod'';
        kdesc = "kc describe";
        kTestDns = ''kubectl run dns-tester --image=busybox --rm --attach --command -- sh -c "cat /etc/resolv.conf; nslookup $POD.$NAMESPACE.pod.cluster.local"'';
        kDbgDns = ''kubectl run -it --rm --image=infoblox/dnstools dns-client'';
        kdJobs = ''kubectl delete jobs `kubectl get jobs -o custom-columns=:.metadata.name`'';
        kdfailed = ''kubectl delete pods --field-selector status.phase=Failed'';

        disasm = "objdump -zd";
      };
    };
  };
}
