#
# Override - use pinentry-gnome3 instead of pinentry-gtk
#
{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkForce;
in {
  home-manager.users.xi = {
    services.gpg-agent = {
      enable = true;
      pinentryPackage = mkForce pkgs.pinentry-gnome3;
    };
  };

  # Required for pinentry-gnome3
  services.dbus.packages = [pkgs.gcr];
}
