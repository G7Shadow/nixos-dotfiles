{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "amd_pstate=active" "processor.max_cstate=5" ];

  # Use latest kernel for best AMD support
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "amdgpu" ];
  
  # Enable firmware
  hardware.enableRedistributableFirmware = true;

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

  # Hyprland configuration
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };
 
  # X Server
  services.xserver = {
  enable = true;
  videoDrivers = [ "amdgpu" ];
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
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;
  programs.noisetorch.enable = true;

  # Hardware
  hardware = {
    cpu.amd.updateMicrocode = true;
    graphics.enable = true;
    bluetooth.enable = true;
  };

      
  # AMD Graphics & Hardware
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  services = {
    fwupd.enable = true;
    fstrim.enable = true;
    dbus.enable = true;
    power-profiles-daemon.enable = false;
  };

    powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";  # or "powersave" for maximum battery
  };

  # Gnome Services
  services = {
    dbus.packages = with pkgs; [
      gcr
      gnome-settings-daemon
    ];
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
  };

  security = {
    pam.services.login.enableGnomeKeyring = true;
    polkit.enable = true;
    rtkit.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  # Sound with pipewire
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Configure keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # User account with shell managed by NixOS
  users.users.jeremyl = {
    isNormalUser = true;
    description = "Jeremy Lee";
    shell = pkgs.zsh; # Set shell at system level
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
    ];
  };

  # Make Zsh available system-wide
  programs.zsh.enable = true;
  programs.bash.enable = false;
  programs.fish.enable = false;

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  services.flatpak.enable = true;
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "25.05";
}
