{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Dev tools
    alejandra
    cmake
    gcc
    opencode
    gnumake
    nodejs
    unzip
    git
    jq
    mesa-demos
    python3
    docker

    # Terminals & CLI utilities
    kitty
    htop
    btop
    lsof
    tree
    wget
    zoxide
    ripgrep
    fzf
    bat
    eza
    fd
    tmux

    # Media & system utilities
    libva
    libva-utils
    brightnessctl
    lm_sensors
    ffmpeg
    pulsemixer
    pwvucontrol
    imagemagick
    obs-studio
    feh
    nautilus

    # Desktop tools (Wayland environment)
    waybar
    hyprpaper
    wlogout
    rofi
    swww
    swaynotificationcenter
    wl-clipboard
    cava
    nwg-look
    gamemode
    mangohud
    inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
    inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
    inputs.quickshell.packages.${stdenv.hostPlatform.system}.default
    vesktop
    spotify

    # Theming
    pywal
    matugen
    bibata-cursors
    nerd-fonts.jetbrains-mono
    adwaita-icon-theme

    # Misc
    playerctl
    nitch
    protonup-ng

    # Language servers
    vscode-langservers-extracted
    lua-language-server
    typescript-language-server
    nil
    hyprls
    pyright

    # Editors
    neovim
    vscode

    # Nixpkgs Search
    (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        (nix-search-tv.overrideAttrs {
          env.GOEXPERIMENT = "jsonv2";
        })
      ];
      text = ''exec "${pkgs.nix-search-tv.src}/nixpkgs.sh" "$@"'';
    })
  ];
}
