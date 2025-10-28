{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = { };

    initExtra = ''
        
      # --- Existing config below ---
      # Kitty shell integration
      if test -n "$KITTY_INSTALLATION_DIR"; then
        export KITTY_SHELL_INTEGRATION="enabled"
        autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
        kitty-integration
        unfunction kitty-integration
      fi

      # Display nitch on shell start
      if command -v nitch >/dev/null 2>&1; then
        nitch
      fi
        
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme



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
}
