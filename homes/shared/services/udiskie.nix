#
# Mounting and unmounting removable media
#
{
  services = {
    udiskie = {
      enable = true;
      automount = true;
      tray = "auto";
    };
  };
}
