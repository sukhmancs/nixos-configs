#
# IDS - Intrusion Detection System tools
#
{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
      lynis
      vulnix
    ];
}