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
    NIXOS_OZONE_WL = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1"; # Required for hardware video decode
    LIBVA_DRIVER_NAME = "radeonsi"; # AMD driver
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
