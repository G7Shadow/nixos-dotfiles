{...}: {
  # Disable power-profiles-daemon
  services.power-profiles-daemon.enable = false;

  # Enable auto-cpufreg sservices
  services.auto-cpufreq.enable = true;
}
