{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkForce;
in {
  networking = {
    networkmanager = {
      enable = true;
      plugins = mkForce [];
      dns = "systemd-resolved";
      unmanaged = [
        "interface-name:tailscale*"
        #"interface-name:br-*"
        #"type:bridge"
        "interface-name:rndis*"
        "interface-name:docker*"
        "interface-name:virbr*"
        "interface-name:vboxnet*"
        "interface-name:waydroid*"
      ];

      wifi = {
        backend = "wpa_supplicant";
        macAddress = "random";
        powersave = true;
        scanRandMacAddress = true;
      };
    };

    # enable IPV6 support
    enableIPv6 = true;
  };
  environment.systemPackages = with pkgs; [networkmanagerapplet];

  systemd.services = {
    NetworkManager-wait-online.enable = false;

    systemd-networkd.stopIfChanged = false;
    systemd-resolved.stopIfChanged = false;
  };

  systemd.network.wait-online.enable = false;
}
