{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    shellAliases = {
      v = "nvim";
      t = "tmux";
    };

    initContent = ''
      if [[ -n "$KITTY_INSTALLATION_DIR" ]]; then
          export KITTY_SHELL_INTEGRATION="no-rc"
          autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
          kitty-integration
          unfunction kitty-integration
      fi

      if command -v nitch &> /dev/null && [ -z "$NITCH_RAN" ]; then
      export NITCH_RAN=1
      nitch
      fi
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
