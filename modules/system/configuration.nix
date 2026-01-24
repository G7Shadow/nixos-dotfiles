{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./desktop.nix
    ./steam.nix
    ./power.nix
    ./audio.nix
    ./services.nix
  ];

  nix.gc = {
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
  nix.optimise.automatic = true;

  networking.hostName = "Omega";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Jamaica";

  # Additional optimizations for Ryzen mobile + Vega
  hardware.cpu.amd.updateMicrocode = true;

  # Fan control - monitors temps and adjusts fan speed
  programs.coolercontrol = {
    enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      libva
      libva-vdpau-driver
    ];
  };
  security = {
    pam.services.login.enableGnomeKeyring = true;
    polkit.enable = true;
    rtkit.enable = true;
  };

  users.users.jeremyl = {
    isNormalUser = true;
    description = "Jeremy Lee";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "render"
      "input"
    ];
  };

  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  programs.bash.enable = false;

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  system.stateVersion = "25.05";
}
