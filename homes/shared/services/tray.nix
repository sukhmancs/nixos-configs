# Original Code by NotAShelf - https://github.com/notashelf/nyx
{
  osConfig,
  lib,
  ...
}: {
  config = {
    # fake a tray to let apps start
    # https://github.com/nix-community/home-manager/issues/2064
    systemd.user.targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = ["graphical-session-pre.target"];
      };
    };
  };
}
