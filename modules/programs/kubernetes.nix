{ config, pkgs, primaryUser, ... }:

{
  home-manager.users.${primaryUser} = {
    home.packages = [
      pkgs.kubectl
      pkgs.kubernetes-helm
    ];

    programs.bash = {
      bashrcExtra = ''
        source <(kubectl completion bash)
        complete -F _complete_alias "''${!BASH_ALIASES[@]}"
      '';
      shellAliases = {
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
      };
    };
  };
}
