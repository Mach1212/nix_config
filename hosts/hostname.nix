{ config, pkgs, primaryUser, hostname, ... }:

{
  networking.hostName = "${primaryUser}_${hostname}";
}
