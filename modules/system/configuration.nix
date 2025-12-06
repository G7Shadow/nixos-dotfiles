{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./desktop.nix
    ./steam.nix
    ./power.nix
    ./boot.nix
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
