# Original Code by NotAShelf - https://github.com/notashelf/nyx
{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    services.dbus.apparmor = "enabled";

    environment.systemPackages = with pkgs; [
      apparmor-pam
      apparmor-utils
      apparmor-parser
      apparmor-profiles
      apparmor-bin-utils
      apparmor-kernel-patches
      libapparmor
    ];

    # apparmor configuration
    security.apparmor = {
      enable = true;

      # whether to enable the AppArmor cache
      # in /var/cache/apparmore
      # enableCache = true;

      # whether to kill processes which have an AppArmor profile enabled
      # but are not confined (AppArmor can only confine new processes)
      killUnconfinedConfinables = true;

      # packages to be added to AppArmor’s include path
      packages = [pkgs.apparmor-profiles];

      # apparmor policies
      policies = {
        "default_deny" = {
          enforce = false;
          enable = false;
          profile = ''
            profile default_deny /** { }
          '';
        };

        "sudo" = {
          enforce = false;
          enable = false;
          profile = ''
            ${pkgs.sudo}/bin/sudo {
              file /** rwlkUx,
            }
          '';
        };

        "nix" = {
          enforce = false;
          enable = false;
          profile = ''
            ${config.nix.package}/bin/nix {
              unconfined,
            }
          '';
        };

        "chrome" = {
          enforce = true;
          enable = true;
          profile = ''
            ${pkgs.google-chrome}/bin/google-chrome-stable {
              # include <abstractions/base>
              # include <abstractions/app/chromium>

              #aa:dbus own bus=session name=org.mpris.MediaPlayer2.chrome path=/org/mpris/MediaPlayer2

              # /usr/bin/google-chrome-stable mrix,

              # @{bin}/man  rPUx, #  For "chrome --help"

              # /opt/google/chrome-stable/chrome_crashpad_handler  rPx -> chrome//&chrome-crashpad-handler,
              # /opt/google/chrome-stable/google-@{name}  rPx,

              # /opt/google/chrome-stable/nacl_helper    rix,
              # /opt/google/chrome-stable/xdg-mime       rix, #-> xdg-mime,
              # /opt/google/chrome-stable/xdg-settings   rix, #-> xdg-settings,

              # /opt/google/chrome-stable/*.so* mr,
              /opt/google/chrome-stable/libwidevinecdm.so mr,
              # /opt/google/chrome-stable/libwidevinecdmadapter.so mr,
              # /opt/google/chrome-stable/WidevineCdm/_platform_specific/linux_*/libwidevinecdm.so mr,

              # include if exists <local/chrome>
            }
          '';
        };
      };
    };
  };
}
