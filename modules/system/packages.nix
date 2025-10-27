{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # Development
    alejandra
    cmake
    gcc
    gnumake
    nodejs
    vscode

    # System Utilities
    brightnessctl
    htop
    tree
    wget
    zoxide
    ripgrep
    fzf
    playerctl
    pulsemixer
    pwvucontrol

    # Multimedia
    ffmpeg
    imagemagick
    obs-studio

    # Desktop Applications
    firefox
    kitty
    vesktop
    nautilus
    pywalfox-native

    # Hyprland Ecosystem
    dunst
    kitty
    rofi
    waybar
    swww
    swaynotificationcenter
    wl-clipboard
    cava
    nwg-look
    matugen

    # Gaming
    mangohud
    protonup

    # Fonts & Themes
    bibata-cursors
    nerd-fonts.jetbrains-mono

    # Utilities
    fastfetch
    nitch

    # Optional useful packages
    bat
    eza
    fd
    jq
    unzip
    git
  ];
}
