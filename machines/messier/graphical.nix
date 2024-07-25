{
  lib,
  pkgs,
  ...
}:
with lib; {
  services.xserver.enable = true;

  # KDE complains if power management is disabled (to be precise, if
  # there is no power management backend such as upower).
  powerManagement.enable = true;

  # Enable sound in graphical iso's.
  hardware.pulseaudio.enable = true;

  # VM guest additions to improve host-guest interaction
  # services.spice-vdagentd.enable = true;
  # services.qemuGuest.enable = true;
  # virtualisation.vmware.guest.enable = pkgs.stdenv.hostPlatform.isx86;
  # virtualisation.hypervGuest.enable = true;
  # services.xe-guest-utilities.enable = pkgs.stdenv.hostPlatform.isx86;
  # The VirtualBox guest additions rely on an out-of-tree kernel module
  # which lags behind kernel releases, potentially causing broken builds.
  # virtualisation.virtualbox.guest.enable = false;

  # Enable plymouth
  boot.plymouth.enable = true;

  environment.defaultPackages = with pkgs; [
    # Firefox for reading the manual.
    firefox
  ];

  isoImage.edition = "gnome";

  # services.xserver.desktopManager.gnome = {
  #   # Add Firefox and other tools useful for installation to the launcher
  #   favoriteAppsOverride = ''
  #     [org.gnome.shell]
  #     favorite-apps=[ 'firefox.desktop', 'nixos-manual.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop', 'gparted.desktop' ]
  #   '';
  #   enable = true;
  # };

  services.xserver.displayManager.gdm = {
    enable = true;
    # autoSuspend makes the machine automatically suspend after inactivity.
    # It's possible someone could/try to ssh'd into the machine and obviously
    # have issues because it's inactive.
    # See:
    # * https://github.com/NixOS/nixpkgs/pull/63790
    # * https://gitlab.gnome.org/GNOME/gnome-control-center/issues/22
    autoSuspend = false;
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "nixos";
  };
}
