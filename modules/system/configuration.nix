{
  pkgs,
  inputs,
  ...
}: {
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
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
  nix.optimise.automatic = true;

  networking.hostName = "Alpha";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Jamaica";

  # Hardware optimized for Ryzen 3 3250U + Vega 3
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [
        mesa.drivers
        libvdpau-va-gl
        libva-vdpau-driver
        libva
      ];
    };

    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    enableAllFirmware = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 10; # Prefer RAM over swap
    "vm.vfs_cache_pressure" = 50; # Keep cache in memory
    "vm.dirty_ratio" = 10; # Start writing at 10%
    "vm.dirty_background_ratio" = 5; # Background writes at 5%
    "kernel.sched_migration_cost_ns" = 5000000; # Reduce CPU migrations
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

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    max-jobs = 4; # Your CPU has 4 threads
    cores = 2; # 2 cores
    auto-optimise-store = true;
  };

  system.stateVersion = "25.05";
}
