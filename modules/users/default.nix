{ config, pkgs, lib, inputs, primaryUser, ... }:

{
  users.mutableUsers = true;

  users.users.${primaryUser} = {
    "mach12" = {
      isNormalUser = true;
      home = "/home/mach12";
      description = "Maciej Pruchnik";
      extraGroups = [ "wheel" ];
      hashedPassword = "$6$0tDihX/rHVXbAsiW$2L3zV26joizHBEVEdgAB6M77Xgf.PeljPBQi4DL.hC3b2.0C9AGSShdpF8lML8d8qAGrbRpLaZ3mf7A.FGcxO.";
      openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDpAKr38MocXOkLtWT//RV+WgbIif9azFZIq17+ppl+tpyyXAk+hAJrsHvYT1yMRoXsuxeJUBAv2v66ajxtHQ5YRk6fTg/r1CB1sa0RoKP1e2xZLbdicHKeBnVH6GX+VPVrXkw1wMKsrc0/28yH3LC69m7ImdkDaBMO50LX1ctODOFwD765MUcsbOtVK7EDGr0BUc+Ck7qhozeBMtS2A55u8M4hSUG0My92iRtB4czlKKYPR56tzXxaE7tR9C12Y6Uq8Ok1D5bOAZeL9wIRoVeaLr290upO5clHyCaUkMIFrshkwUQR0E4iV0nACvrzj9Hzm/4sWlpsQkTI5lUcCKMj ssh-key-2023-11-18" ];
    };
  }."${primaryUser}";
}
