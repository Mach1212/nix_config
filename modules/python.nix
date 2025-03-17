{
  config,
  pkgs,
  lib,
  inputs,
  primaryUser,
  ...
}: {
  home-manager.users.${primaryUser} = {
    home.packages = [
      # If having problems linking, delete compiler_compat/ld. Then it'll use system ld.
      (pkgs.conda.overrideAttrs (oldAttrs: {
        libPath = lib.makeLibraryPath [
          pkgs.zlib
          pkgs.zstd
          pkgs.stdenv.cc.cc
          pkgs.curl
          pkgs.libxcrypt
          pkgs.openssl
          pkgs.attr
          pkgs.libssh
          pkgs.bzip2
          pkgs.libxml2
          pkgs.acl
          pkgs.libsodium
          pkgs.util-linux
          pkgs.xz
          pkgs.systemd
        ];
      }))
    ];

    programs.bash.bashrcExtra =
      #bash
      ''
        . /home/${primaryUser}/.conda/etc/profile.d/conda.sh
        if ! command -v conda &> /dev/null; then
          conda-shell
          exit 0
        fi
        set -h
        conda activate base
        if ! command -v python &> /dev/null; then
          echo "Python is not installed. Installing Python..."
          conda install -y python
        fi
        if ! command -v cython &> /dev/null; then
          echo "Cython is not installed. Installing Cython..."
          conda install -y cython
        fi
      '';
  };
}
