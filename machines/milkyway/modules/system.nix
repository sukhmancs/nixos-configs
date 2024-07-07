{
  config,
  pkgs,
  ...
}: {
  config = {
    boot.loader.systemd-boot.enable = true;
    boot.plymouth.enable = true;
    # services.seatd.enable = true;
    xdg.portal.enable = true;
    services.tailscale.enable = true;

    modules.system = {
      mainUser = "xi";
      impermanence.root.enable = true;

      encryption = {
        enable = true;
        device = "enc";
      };
    };
  };
}
