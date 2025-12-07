{...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    shellAliases = {
      # Basic
      v = "nvim";
      t = "tmux";

      # Git aliases
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline";
      gd = "git diff";

      # Eza (modern ls)
      ls = "eza --icons";
      ll = "eza -l --icons";
      la = "eza -la --icons";
      lt = "eza --tree --icons";

      # Other useful aliases
      cat = "bat";
      cd = "z";

      # NixOS shortcuts
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#Alpha";
      nrt = "sudo nixos-rebuild test --flake ~/nixos-dotfiles#Alpha";
      nfu = "nix flake update ~/nixos-dotfiles";
    };

    # Changed from initContent to initExtra
    initContent = ''
      # Only run nitch once per session
      if command -v nitch &> /dev/null && [ -z "$NITCH_RAN" ]; then
        export NITCH_RAN=1
        nitch
      fi
    '';

    # Optimize completion loading
    completionInit = ''
      autoload -Uz compinit
      # Only check cache once a day
      if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
        compinit
      else
        compinit -C
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
