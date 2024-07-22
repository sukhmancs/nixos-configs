{
  # enable flatpak, as well as xdgp to communicate with the host filesystems
  services.flatpak.enable = true;

  environment.sessionVariables.XDG_DATA_DIRS = ["/var/lib/flatpak/exports/share"];
}
