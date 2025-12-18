{...}: {
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelParams = ["amd_pstate=active"];
}
