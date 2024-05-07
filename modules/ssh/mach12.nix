{ primaryUser, ... }:

{
  home-manager.users."${primaryUser}" = {
    home.file.".ssh/authorized_keys".text = ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDpAKr38MocXOkLtWT//RV+WgbIif9azFZIq17+ppl+tpyyXAk+hAJrsHvYT1yMRoXsuxeJUBAv2v66ajxtHQ5YRk6fTg/r1CB1sa0RoKP1e2xZLbdicHKeBnVH6GX+VPVrXkw1wMKsrc0/28yH3LC69m7ImdkDaBMO50LX1ctODOFwD765MUcsbOtVK7EDGr0BUc+Ck7qhozeBMtS2A55u8M4hSUG0My92iRtB4czlKKYPR56tzXxaE7tR9C12Y6Uq8Ok1D5bOAZeL9wIRoVeaLr290upO5clHyCaUkMIFrshkwUQR0E4iV0nACvrzj9Hzm/4sWlpsQkTI5lUcCKMj'';
  };
}
