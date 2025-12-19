{config, ...}: let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/modules/home/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    hypr = "hypr";
    rofi = "rofi";
    waybar = "waybar";
    quickshell = "quickshell";
    kitty = "kitty";
    matugen = "matugen";
    nvim = "nvim";
    tmux = "tmux";
  };
in {
  home.username = "jeremyl";
  home.homeDirectory = "/home/jeremyl";
  home.stateVersion = "25.05";

  imports = [
    ./packages.nix
    ./programs/git.nix
    ./programs/zsh.nix
  ];

  xdg.configFile =
    builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.sessionVariables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
    VISUAL = "nvim";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";

    # AMD Vega 3 iGPU optimizations
    RADV_PERFTEST = "aco"; # ACO shader compiler
    AMD_VULKAN_ICD = "RADV";

    # Wayland optimizations
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";

    # Memory optimization (14GB RAM)
    MALLOC_ARENA_MAX = "2";

    # Node.js (lighter for 14GB)
    NODE_OPTIONS = "--max-old-space-size=2048"; # 2GB instead of 4GB

    # Gaming optimizations for Vega 3
    DXVK_STATE_CACHE_PATH = "\${HOME}/.cache/dxvk";
    DXVK_HUD = "0";
    mesa_glthread = "true";

    # Compilation (use all 4 threads)
    MAKEFLAGS = "-j4";
  };
}
