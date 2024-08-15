{
  pkgs,
  lib,
  ...
}: {
  environment = {
    defaultPackages = lib.mkForce [];
    systemPackages = with pkgs; [
      git
      curl
      wget
      pciutils
      lshw
      bind.dnsutils
    ];
  };
}
