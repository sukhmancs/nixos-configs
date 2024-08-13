#
# IDS - Intrusion Detection System tools
# Usage:
#   `vulnix -S -D -j` for system scan, output with description, and json output
#
{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
      vulnix
      lynis
    ];
}