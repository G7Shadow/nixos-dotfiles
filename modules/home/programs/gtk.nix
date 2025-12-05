{pkgs, ...}: {
  # GTK Configuration for proper icon display
  gtk = {
    enable = true;

    # Icon theme - choose one that's installed
    iconTheme = {
      name = "Adwaita"; # Default GNOME icons (always available)
      package = pkgs.adwaita-icon-theme;
    };

    # GTK theme
    theme = {
      name = "Adwaita-dark"; # Matches your dark setup
      package = pkgs.gnome-themes-extra;
    };

    # Cursor theme (you already have Bibata in packages)
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    # Font configuration
    font = {
      name = "Sans";
      size = 11;
    };

    # GTK3 settings
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "menu:close";
    };

    # GTK4 settings
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "menu:close";
    };
  };

  # XDG settings for proper theming
  xdg.configFile = {
    # Ensure GTK settings are readable
    "gtk-3.0/settings.ini".force = true;
    "gtk-4.0/settings.ini".force = true;
  };

  # Session variables for GTK apps
  home.sessionVariables = {
    # Ensure GTK apps can find icons
    GTK_THEME = "Adwaita-dark";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  # Install required packages if not already present
  home.packages = with pkgs; [
    # Icon themes (choose what you like)
    adwaita-icon-theme # Default GNOME icons
    gnome-themes-extra # Additional GTK themes
    hicolor-icon-theme # Fallback icon theme

    # Optional: Popular icon themes
    # papirus-icon-theme        # Modern, colorful
    # numix-icon-theme          # Clean, simple
    # tela-icon-theme           # macOS-like
  ];
}
