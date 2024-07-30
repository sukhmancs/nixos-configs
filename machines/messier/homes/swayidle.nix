{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe mkIf;
  locker = getExe pkgs.swaylock-effects;

  systemctl = "${pkgs.systemd}/bin/systemctl";
  suspendScript = pkgs.writeShellScript "suspend-script" ''
    ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
    # only suspend if audio isn't running
    if [ $? == 1 ]; then
      ${systemctl} suspend
    fi
  '';
in {
  config = {
    # systemd.user.services.swayidle.Install.WantedBy = ["hyprland-session.target"];

    # screen idle
    services.swayidle = {
      extraArgs = ["-d" "-w"];
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.systemd}/bin/loginctl lock-session";
        }
        {
          event = "lock";
          command = "${locker}";
        }
      ];
      timeouts = [
        {
          timeout = 900;
          command = suspendScript.outPath;
        }
      ];
    };
  };
}
