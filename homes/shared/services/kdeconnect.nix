{pkgs, ...}: {
  services.kdeconnect = {
    enable = false;
    indicator = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
}
