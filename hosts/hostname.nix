{ config, pkgs, primaryUser, hostname, ... }:

{
  networking.hostName = "${primaryUser}₪${hostname}";
}
