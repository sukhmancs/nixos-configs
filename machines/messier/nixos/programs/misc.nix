{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gitMinimal
    curl
    wget
    pciutils
    lshw
    rsync
    nixos-install-tools
    ranger
    libnotify
  ];
}
