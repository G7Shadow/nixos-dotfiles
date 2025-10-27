{ config, ... }:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/modules/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    hypr = "hypr";
    # rofi = "rofi";
    waybar = "waybar";
    kitty = "kitty";
  };
in
{
  home.username = "jeremyl";
  home.homeDirectory = "/home/jeremyl";
  home.stateVersion = "25.05";

  # Enable Home Manager
  programs.home-manager.enable = true;

  imports = [
    ./modules/system/packages.nix
    ./modules/config/git/git.nix
    ./modules/config/zsh/zsh.nix
    ./modules/config/nvim/nixvim.nix
  ];

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  home.sessionVariables = {
    EDITOR = "nvim";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
