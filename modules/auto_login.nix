{ config, pkgs, lib, inputs, primaryUser, ... }:

{
  services.getty.autologinUser = "${primaryUser}";
}
