# Original Code by NotAShelf - https://github.com/notashelf/nyx
{config, ...}: let
  revision =
    if config.system.configurationRevision != null
    then " @ " + config.system.configurationRevision
    else "";
in {
  services.getty.greetingLine = "<<< Welcome to ${config.networking.hostName} @ ${revision} >>>";
}
