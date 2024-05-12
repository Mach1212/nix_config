{ config, pkgs, primaryUser, ... }:

{
  imports = [
    ./sops.nix
  ];

  sops.secrets = {
    "k3s/server-ca-crt" = {
      owner = primaryUser;
      path = "/home/${primaryUser}/.kube/certs/server-ca.crt";
    };
    "k3s/client-admin-crt" = {
      owner = primaryUser;
      path = "/home/${primaryUser}/.kube/certs/client-admin.crt";
    };
    "k3s/client-admin-key" = {
      owner = primaryUser;
      path = "/home/${primaryUser}/.kube/certs/client-admin.key";
    };
  };
  
  system.userActivationScripts.setup_astro_config.text =
    let
      path = "~/k3s";
      text = ''
        apiVersion: v1
        clusters:
        - cluster:
            certificate-authority: certs/server-ca.crt
            server: https://k8s.mpruchn.com:6443
          name: local
        contexts:
        - context:
            cluster: local
            namespace: mach12
            user: user
          name: Default
        current-context: Default
        kind: Config
        preferences: {}
        users:
        - name: user
          user:
            client-certificate: certs/client-admin.crt
            client-key: certs/client-admin.key
      '';
    in
    ''
      if [ ! -d ${path} ]; then
        echo ${text} >${path}
      fi
    '';
  
  home-manager.users.${primaryUser} = {
    home.packages = [
      pkgs.kubectl
      pkgs.kubernetes-helm
      pkgs.ansible-lint
      pkgs.kompose
    ];

    programs.bash = {
      bashrcExtra = ''
        source <(kubectl completion bash)
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
