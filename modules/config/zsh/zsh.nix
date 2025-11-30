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
