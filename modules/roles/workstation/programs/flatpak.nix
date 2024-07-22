{
  # enable flatpak, as well as xdgp to communicate with the host filesystems
  services.flatpak.enable = false; # I don't like to use flatpak

  environment.sessionVariables.XDG_DATA_DIRS = ["/var/lib/flatpak/exports/share"];
}
