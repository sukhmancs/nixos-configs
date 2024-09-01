#
# RBW - Bitwarden CLI
#
{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig) modules;

  sys = modules.home;
  prg = sys.programs;

  rbwConfig = {
    email = "shelf@xilain.dev"; # Required
    sso_id = ""; # Optional, leave empty if not using SSO
    base_url = "https://vault.xilain.dev/"; # Optional, default is set
    ui_url = "https://vault.xilain.dev/"; # Optional
    lock_timeout = "32400"; # Optional, default is 3600 seconds (1 hour), 32400 seconds (9 hours)
    sync_interval = "3600"; # Optional, default is 3600 seconds (1 hour)
    pinentry = "${pkgs.pinentry-gnome3}/bin/pinentry-gnome3"; # Optional, default is pinentry
  };

  # Convert the configuration to the format expected by rbw
  rbwConfigText = lib.concatStringsSep "\n" (lib.mapAttrsToList (name: value: ''rbw config set ${name} "${value}"'') rbwConfig);

  # Script to apply configuration
  setupRbwConfigScript = pkgs.writeShellScriptBin "setup-rbw-config" ''
    #!/usr/bin/env bash
    ${rbwConfigText}
  '';
in {
  config = mkIf prg.rbw.enable {
    home.packages = with pkgs; [
      rbw
      setupRbwConfigScript
    ];

    # Ensure the script is executed to apply the configuration
    systemd.user.services.rbw-config = {
      Unit = {
        Description = "Configure rbw (Bitwarden CLI)";
        After = ["network-online.target"];
        Wants = ["network-online.target"];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${setupRbwConfigScript}/bin/setup-rbw-config";
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
  };
}
