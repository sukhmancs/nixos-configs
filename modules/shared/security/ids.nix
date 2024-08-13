#
# IDS - Intrusion Detection System tools
#
{
  environment.systemPackages = with pkgs; [
      lynis
      vulnix
    ];
}