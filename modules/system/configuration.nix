{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelParams = ["amd_pstate=guided"];
  boot.kernelModules = ["amdgpu"];

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

  # Enable Hyprland window manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  # X Server
  services = {
    xserver.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Display Manager
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "jeremyl";
    defaultSession = "hyprland";
    sddm = {
      enable = true;
    };
  };

  # Gaming
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      extraCompatPackages = [pkgs.proton-ge-bin];

      # Enable Steam Input for controller support
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            # Controller support libraries
            libusb1
            udev
            SDL2

            # Additional libraries for better compatibility
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            xorg.libXcomposite
            xorg.libXdamage
            xorg.libXrender
            xorg.libXext

            # Fix for Xwayland symbol errors
            libkrb5
            keyutils
          ];
      };
    };
  };

  # Hardware
  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      mesa
      libvdpau-va-gl
      libva-vdpau-driver
    ];

    extraPackages32 = with pkgs; [
      driversi686Linux.mesa
    ];
  };

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services = {
    fwupd.enable = true;
    fstrim.enable = true;
    dbus.enable = true;
    power-profiles-daemon.enable = false;
  };

  # Auto-Cpufreg
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    charger = {
      governor = "performance";
      scaling_min_freq = 1400000; # 1.4 GHz min for responsiveness
      scaling_max_freq = 2600000; # 2.6 GHz max (base clock)
      turbo = "auto"; # Enable boost to 3.5 GHz when needed
    };

    battery = {
      governor = "schedutil"; # Better for mobile CPUs
      scaling_min_freq = 400000; # 400 MHz - save power
      scaling_max_freq = 2600000; # Full performance available
      turbo = "auto"; # Smart boost management
    };
  };

  security = {
    pam.services.login.enableGnomeKeyring = true;
    polkit.enable = true;
    rtkit.enable = true;
  };

  # Configure keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  i18n.defaultLocale = "en_US.UTF-8";

  # User account with shell managed by NixOS
  users.users.jeremyl = {
    isNormalUser = true;
    description = "Jeremy Lee";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
    ];
  };

  # Make Zsh available system-wide
  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  programs.bash.enable = false;

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  services.flatpak.enable = true;
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "25.05";
}
