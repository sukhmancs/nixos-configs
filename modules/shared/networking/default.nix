{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkForce mkDefault;
in {
  imports = [
    ./firewall

    ./blocker.nix
    ./network-manager.nix
    ./networking.nix
    # ./optimize.nix
    ./resolved.nix
    ./ssh.nix
    # ./wireless.nix
  ];

  # network tools that are helpful and nice to have
  boot.kernelModules = ["af_packet"];
  environment.systemPackages = with pkgs; [
    mtr
    tcpdump
    traceroute
  ];

  # enable wireless database, it helps with finding the right channels
  hardware.wirelessRegulatoryDatabase = true;
}
