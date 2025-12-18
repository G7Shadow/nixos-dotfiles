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

  security = {
    pam.services.login.enableGnomeKeyring = true;
    polkit.enable = true;
    rtkit.enable = true;
  };

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

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "25.05";
}
