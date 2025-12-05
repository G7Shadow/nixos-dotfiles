{...}: {
  programs.git = {
    enable = true;
    userName = "G7Shadow";
    userEmail = "l.jeremy.822001@gmail.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nvim";
    };
  };
}
