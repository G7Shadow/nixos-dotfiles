{...}: {
  services = {
    fwupd.enable = true;
    fstrim.enable = true;
    dbus.enable = true;
  };
  # Configure keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  i18n.defaultLocale = "en_US.UTF-8";

  services.flatpak.enable = true;
}
