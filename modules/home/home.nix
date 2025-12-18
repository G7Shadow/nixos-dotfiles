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
    # Existing
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
    VISUAL = "nvim";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";

    # Performance optimizations
    # Wayland performance (already partially set in Hyprland)
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";

    # AMD GPU optimizations
    RADV_PERFTEST = "aco,ngg"; # Enable ACO compiler and NGG culling
    AMD_VULKAN_ICD = "RADV"; # Use RADV Vulkan driver

    # Compilation performance
    MAKEFLAGS = "-j\${toString (builtins.div (builtins.readFile /proc/cpuinfo |> builtins.split \"processor\" |> builtins.length) 2)}"; # Parallel builds

    # Reduce memory fragmentation
    MALLOC_ARENA_MAX = "2";

    # Node.js performance (you have nodejs installed)
    NODE_OPTIONS = "--max-old-space-size=4096";

    # Gaming/Proton optimizations
    DXVK_STATE_CACHE_PATH = "\${HOME}/.cache/dxvk";
    DXVK_HUD = "0"; # Disable HUD for performance
    PROTON_ENABLE_NVAPI = "0"; # Disable for AMD
    PROTON_FORCE_LARGE_ADDRESS_AWARE = "1";

    # Vulkan optimizations
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
  };
}
