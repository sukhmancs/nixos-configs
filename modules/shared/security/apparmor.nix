# Original Code by NotAShelf - https://github.com/notashelf/nyx
{
  config,
  pkgs,
  lib,
  ...
}: let
  getLib = lib.getLib;

  # Todo add it flake-parts/default/packages with nvfetcher support to autoupdate it
  apparmorProfiles = pkgs.stdenvNoCC.mkDerivation {
    pname = "apparmor-rules";
    version = "0-unstable-2024-08-02";

    src = pkgs.fetchFromGitHub {
      owner = "sukhmancs";
      repo = "apparmor.d";
      rev = "ad60ee11ad6c43d32ef0396e340ec4e446288d69";
      hash = "sha256-UiytwQXAgvvBp7hGpqoLMQZTrZ7uBxutML04Q343RCM=";
    };

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall
      mkdir -p $out/etc/apparmor.d
      cp -r apparmor.d/* $out/etc/apparmor.d
      runHook postInstall
    '';

    passthru.updateScript = pkgs.unstableGitUpdater { };

    meta = {
      homepage = "https://github.com/roddhjav/apparmor.d";
      description = "Over 1500 AppArmor profiles aiming to confine most linux processes tailored for NixOS";
      longDescription = ''
        AppArmor.d is a set of over 1500 AppArmor profiles whose aim is to confine
        most Linux based applications and processes. Confines all system services, user services
        and most desktop environments.
      '';
      license = lib.licenses.gpl2;
      platforms = lib.platforms.linux;
      maintainers = with lib.maintainers; [
        xi
      ];
    };
  };
in {
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
      # roddhjav-apparmor-rules
    ];

    # apparmor configuration
    security.apparmor = {
      enable = true;

      # whether to enable the AppArmor cache
      # in /var/cache/apparmore
      enableCache = true;

      # whether to kill processes which have an AppArmor profile enabled
      # but are not confined (AppArmor can only confine new processes)
      killUnconfinedConfinables = true;

      # packages to be added to AppArmor’s include path
      packages = [pkgs.apparmor-profiles];

      #TODO: for some reason, these profiles are not being applied, even though they are loaded and enforced
      # apparmor policies
      policies = {
        "bin.chrome" = {
          enable = true;
          enforce = true;
          profile = builtins.readFile "${apparmorProfiles}/etc/apparmor.d/groups/browsers/chrome";
          # profile = builtins.readFile "${pkgs.roddhjav-apparmor-rules}/etc/apparmor.d/groups/browsers/chrome";
          # profile = ''
          #   # apparmor.d - Full set of apparmor profiles
          #   # Copyright (C) 2018-2021 Mikhail Morfikov
          #   # Copyright (C) 2022-2024 Alexandre Pujol <alexandre@pujol.io>
          #   # SPDX-License-Identifier: GPL-2.0-only

          #   abi <abi/3.0>,

          #   include <tunables/global>

          #   @{name} = chrome{,-beta,-stable,-unstable}
          #   @{domain} = com.google.Chrome
          #   @{lib_dirs} = /opt/google/@{name}
          #   @{config_dirs} = @{user_config_dirs}/google-@{name}
          #   @{cache_dirs} = @{user_cache_dirs}/google-@{name}

          #   @{exec_path} = @{lib_dirs}/@{name}
          #   profile chrome @{exec_path} {
          #     include <abstractions/base>

          #     #aa:dbus own bus=session name=org.mpris.MediaPlayer2.chrome path=/org/mpris/MediaPlayer2

          #     @{exec_path} mrix,

          #     @{lib_dirs}/chrome_crashpad_handler  rPx -> chrome//&chrome-crashpad-handler,
          #     @{lib_dirs}/google-@{name}  rPx,

          #     @{lib_dirs}/nacl_helper    rix,
          #     @{lib_dirs}/xdg-mime       rix, #-> xdg-mime,
          #     @{lib_dirs}/xdg-settings   rix, #-> xdg-settings,

          #     @{lib_dirs}/*.so* mr,
          #     @{lib_dirs}/libwidevinecdm.so mr,
          #     @{lib_dirs}/libwidevinecdmadapter.so mr,
          #     @{lib_dirs}/WidevineCdm/_platform_specific/linux_*/libwidevinecdm.so mr,

          #     include if exists <local/chrome>
          #   }

          #   # vim:syntax=apparmor
          # '';
        };
        "bin.discord" = {
          enable = true;  # Set to true to load the profile into the kernel
          enforce = true; # Set to true to enforce the policy, false to only complain in the logs
          profile = builtins.readFile "${apparmorProfiles}/etc/apparmor.d/groups/apps/discord";
          # profile = ''
          #   # Apparmor profile for discord
          #   #include <tunables/global>
          #   ${pkgs.discord}/sw/bin/discord {
          #     #include <abstractions/X>
          #     #include <abstractions/audio>
          #     #include <abstractions/base>
          #     #include <abstractions/consoles>
          #     #include <abstractions/dbus-session-strict>
          #     #include <abstractions/dbus-strict>
          #     #include <abstractions/fonts>
          #     #include <abstractions/freedesktop.org>
          #     #include <abstractions/nameservice>
          #     #include <abstractions/user-tmp>

          #     capability sys_admin,
          #     capability sys_chroot,
          #     capability sys_ptrace,

          #     signal send set=term peer=discord,

          #     deny ptrace read peer=unconfined,

          #     ptrace (read,trace) peer=discord,

          #     deny /bin/dash mrx,
          #     deny /usr/bin/python3.6 mr,
          #     deny /home/*/.pki/** w,
          #     owner /home/*/.pki/** r,

          #     /dev/ r,
          #     /etc/gtk-3.0/settings.ini r,
          #     /etc/lsb-release r,
          #     /etc/fstab r,
          #     /home/*/bin/Discord/Discord mrix,
          #     /lib/x86_64-linux-gnu/ld-*.so mr,
          #     /proc/ r,
          #     /proc/filesystems r,
          #     /proc/self/exe mrix,
          #     /proc/sys/fs/inotify/max_user_watches r,
          #     /proc/sys/kernel/yama/ptrace_scope r,
          #     /sys/** r,
          #     /usr/bin/lsb_release Ux,
          #     /usr/bin/lsb_release r,
          #     /usr/bin/xdg-open Ux,
          #     /usr/bin/xdg-open r,
          #     /usr/share/fontconfig/conf.avail/ r,
          #     /usr/share/drirc.d/00-mesa-defaults.conf r,
          #     /usr/share/themes/** r,
          #     /usr/share/gvfs/remote-volume-monitors/* r,
          #     /usr/share/glib-2.0/schemas/gschemas.compiled r,
          #     /var/cache/fontconfig/ w,

          #     / r,
          #     /**/ r,

          #     owner /dev/shm/.org.chromium.Chromium.* rw,
          #     owner /run/user/*/dconf/user r,
          #     owner /home/*/.Xauthority r,
          #     owner /home/*/.cache/mesa_shader_cache/* rwk,
          #     owner /home/*/.cache/fontconfig/* rw,
          #     owner /home/*/.cache/fontconfig/* wl,
          #     owner /home/*/.config/discord/** mrwk,
          #     owner /home/*/.config/user-dirs.dirs r,
          #     owner /home/*/.config/gtk-3.0/bookmarks r,
          #     owner /home/*/#[0-9]* mrw,
          #     owner /home/*/bin/Discord/** r,
          #     owner /home/*/bin/Discord/**.so mr,
          #     owner /proc/*/{clear_refs,gid_map,setgroups,uid_map} w,
          #     owner /proc/*/{cmdline,fd/,maps,stat,statm,status,task/,mounts,mountinfo} r,
          #     owner /proc/*/task/*/status r,

          #     owner /run/user/*/discord-ipc-0 w,
          #     owner /usr/local/share/fonts/** rw,
          #     owner /usr/share/fonts/** rw,
          #     owner /usr/share/javascript/*/fonts/** rw,
          #     owner /usr/share/poppler/cMap/** rw,
          #   }
          # '';
        };

        "bin.transmission-daemon" = {
          enable = true; # Set to true to load the profile into the kernel
          enforce = true; # Set to true to enforce the policy, false to only complain in the logs
          profile = builtins.readFile "${apparmorProfiles}/etc/apparmor.d/profiles-s-z/transmission";
          # profile = ''
          #   # AppArmor profile contents go here
          #   # Example:
          #   include <tunables/global>

          #   ${pkgs.transmission_4}/bin/transmission-daemon {
          #     include <abstractions/base>
          #     include <abstractions/nameservice>

          #     ${getLib pkgs.glibc}/lib/*.so                    mr,
          #     ${getLib pkgs.libevent}/lib/libevent*.so*        mr,
          #     ${getLib pkgs.curl}/lib/libcurl*.so*             mr,
          #     ${getLib pkgs.openssl}/lib/libssl*.so*           mr,
          #     ${getLib pkgs.openssl}/lib/libcrypto*.so*        mr,
          #     ${getLib pkgs.zlib}/lib/libz*.so*                mr,
          #     ${getLib pkgs.libssh2}/lib/libssh2*.so*          mr,
          #     ${getLib pkgs.systemd}/lib/libsystemd*.so*       mr,
          #     ${getLib pkgs.xz}/lib/liblzma*.so*               mr,
          #     ${getLib pkgs.libgcrypt}/lib/libgcrypt*.so*      mr,
          #     ${getLib pkgs.libgpg-error}/lib/libgpg-error*.so* mr,
          #     ${getLib pkgs.nghttp2}/lib/libnghttp2*.so*       mr,
          #     ${getLib pkgs.c-ares}/lib/libcares*.so*          mr,
          #     ${getLib pkgs.libcap}/lib/libcap*.so*            mr,
          #     ${getLib pkgs.attr}/lib/libattr*.so*             mr,
          #     ${getLib pkgs.lz4}/lib/liblz4*.so*               mr,
          #     ${getLib pkgs.libkrb5}/lib/lib*.so*              mr,
          #     ${getLib pkgs.keyutils}/lib/libkeyutils*.so*     mr,
          #     ${getLib pkgs.util-linuxMinimal.out}/lib/libblkid.so.* mr,
          #     ${getLib pkgs.util-linuxMinimal.out}/lib/libmount.so.* mr,
          #     ${getLib pkgs.util-linuxMinimal.out}/lib/libuuid.so.* mr,
          #     ${getLib pkgs.gcc.cc.lib}/lib/libstdc++.so.* mr,
          #     ${getLib pkgs.gcc.cc.lib}/lib/libgcc_s.so.* mr,

          #     @{PROC}/sys/kernel/random/uuid   r,
          #     @{PROC}/sys/vm/overcommit_memory r,

          #     ${pkgs.openssl.out}/etc/**                     r,
          #     ${pkgs.transmission_4}/share/transmission/** r,
          #   }
          # '';
        };
        # "bin.google-chrome" = {
        #   enable = true; # Load the profile into the kernel
        #   enforce = true; # Enforce the policy
        #   profile = ''
        #     # Custom AppArmor profile for Google Chrome
        #     #include <tunables/global>

        #     ${pkgs.google-chrome}/bin/google-chrome{,-beta,-stable,-unstable} {
        #       # include <abstractions/X>
        #       # include <abstractions/audio>
        #       # include <abstractions/base>
        #       # include <abstractions/dbus-session-strict>
        #       # include <abstractions/dbus-strict>
        #       # include <abstractions/fonts>
        #       # include <abstractions/freedesktop.org>
        #       # include <abstractions/nameservice>
        #       # include <abstractions/user-tmp>
        #       # include <abstractions/cups-client>

        #       capability sys_admin,
        #       capability sys_chroot,
        #       capability sys_ptrace,

        #       deny ptrace peer=unconfined,
        #       ptrace read peer=google_chrome,

        #       deny /bin/dash mr,

        #       /dev/dri/ r,
        #       /etc/gtk-3.0/settings.ini r,
        #       /lib/x86_64-linux-gnu/ld-*.so mr,
        #       /opt/google/chrome/** r,
        #       /opt/google/chrome/chrome mix,
        #       #/opt/google/chrome/google-chrome ix,
        #       /opt/google/chrome/chrome_crashpad_handler mix,
        #       /opt/google/chrome/nacl_helper mix,
        #       /opt/google/chrome/**.so m,
        #       /proc/ r,
        #       /proc/*/stat r,
        #       /proc/filesystems r,
        #       /proc/self/exe mrix,
        #       /proc/stat r,
        #       /proc/sys/fs/inotify/max_user_watches r,
        #       /proc/sys/kernel/yama/ptrace_scope r,
        #       /sys/** r,
        #       /usr/bin/keepassxc-proxy PUx,
        #       /usr/bin/xdg-settings Ux,
        #       /usr/bin/xdg-settings r,
        #       /run/udev/data/* r,
        #       /usr/lib/x86_64-linux-gnu/dri/nouveau_dri.so mr,
        #       /usr/share/drirc.d/ r,
        #       /usr/share/drirc.d/00-mesa-defaults.conf r,
        #       /usr/share/fontconfig/conf.avail/ r,
        #       /usr/share/themes/** r,
        #       /usr/share/gvfs/remote-volume-monitors/* r,
        #       /usr/share/glib-2.0/schemas/gschemas.compiled r,

        #       / r,
        #       /**/ r,
        #       owner /home/*/Public/GoogleChrome/** rw,

        #       owner /dev/shm/.com.google.Chrome.* rw,
        #       owner /home/*/#[0-9]* mrw,
        #       owner /home/*/.Xauthority r,
        #       owner /home/*/.cache/google-chrome/** rw,
        #       owner /home/*/.cache/fontconfig/* r,
        #       owner /home/*/.cache/mesa_shader_cache/** rwk,
        #       owner /home/*/.config/gtk-3.0/bookmarks r,
        #       owner /home/*/.config/ r,
        #       owner /home/*/.config/google-chrome/ r,
        #       owner /home/*/.config/google-chrome/** rwk,
        #       owner /home/*/.config/user-dirs.dirs r,
        #       owner /home/*/.pki/nssdb/cert9.db rwk,
        #       owner /home/*/.pki/nssdb/key4.db rwk,
        #       owner /home/*/.pki/nssdb/pkcs11.txt r,
        #       owner /proc/*/{cmdline,statm} r,
        #       owner /proc/*/{gid_map,oom_score_adj,setgroups,uid_map,clear_refs} w,
        #       owner /proc/*/task/*/status r,

        #       # Deny access to sensitive files
        #       deny /etc/shadow mr,
        #       deny /etc/gshadow mr,
        #       deny /etc/passwd mr,

        #     #System bus
        #       dbus send
        #         bus=system
        #         interface=org.freedesktop.DBus.Properties
        #         member=Get,

        #       dbus send
        #         interface=org.gtk.Private.RemoteVolumeMonitor
        #         member={IsSupported,List},

        #       dbus send
        #         bus=system
        #         path=/org/freedesktop/UPower
        #         interface=org.freedesktop.UPower
        #         member={EnumerateDevices,GetDisplayDevice},

        #     #Session bus

        #       dbus send
        #         bus=session
        #         interface=org.freedesktop.DBus.Properties
        #         member=GetAll,

        #       # Mount service
        #       dbus send
        #         bus=session
        #         path=/org/gtk/vfs/Daemon
        #         interface=org.gtk.vfs.Daemon
        #         member=ListMonitorImplementations,

        #       dbus send
        #         bus=session
        #         path=/org/gtk/vfs/mounttracker
        #         interface=org.gtk.vfs.MountTracker
        #         member=ListMountableInfo,

        #       # Secret service
        #       dbus send
        #         bus=session
        #         path=/org/freedesktop/secrets
        #         interface=org.freedesktop.Secret.Service
        #         member={SearchItems,Unlock,OpenSession},

        #       dbus send
        #         bus=session
        #         path=/org/freedesktop/secrets
        #         interface=org.freedesktop.Secret.Service
        #         member=GetSecrets,

        #       dbus send
        #         bus=session
        #         path=/org/freedesktop/secrets/aliases/default
        #         interface=org.freedesktop.Secret.Collection
        #         member=CreateItem,

        #       # Screensaver inhibit
        #       dbus send
        #         bus=session
        #         path=/org/freedesktop/ScreenSaver
        #         interface=org.freedesktop.ScreenSaver
        #         member={Inhibit,UnInhibit},

        #       dbus send
        #         bus=session
        #         path=/org/freedesktop/PowerManagement/Inhibit
        #         interface=org.freedesktop.PowerManagement.Inhibit
        #         member={Inhibit,UnInhibit},
        #     }
        #   '';
        # };



        # "default_deny" = {
        #   enforce = false;
        #   enable = false;
        #   profile = ''
        #     profile default_deny /** { }
        #   '';
        # };

        # "sudo" = {
        #   enforce = false;
        #   enable = false;
        #   profile = ''
        #     ${pkgs.sudo}/bin/sudo {
        #       file /** rwlkUx,
        #     }
        #   '';
        # };

        # "nix" = {
        #   enforce = false;
        #   enable = false;
        #   profile = ''
        #     ${config.nix.package}/bin/nix {
        #       unconfined,
        #     }
        #   '';
        # };

        # "chrome" = {
        #   enforce = false;
        #   enable = false;
        #   profile = ''
        #     ${pkgs.google-chrome}/bin/google-chrome-stable {
        #       # include <abstractions/base>
        #       # include <abstractions/app/chromium>

        #       #aa:dbus own bus=session name=org.mpris.MediaPlayer2.chrome path=/org/mpris/MediaPlayer2

        #       # /usr/bin/google-chrome-stable mrix,

        #       # @{bin}/man  rPUx, #  For "chrome --help"

        #       # /opt/google/chrome-stable/chrome_crashpad_handler  rPx -> chrome//&chrome-crashpad-handler,
        #       # /opt/google/chrome-stable/google-@{name}  rPx,

        #       # /opt/google/chrome-stable/nacl_helper    rix,
        #       # /opt/google/chrome-stable/xdg-mime       rix, #-> xdg-mime,
        #       # /opt/google/chrome-stable/xdg-settings   rix, #-> xdg-settings,

        #       # /opt/google/chrome-stable/*.so* mr,
        #       /opt/google/chrome-stable/libwidevinecdm.so mr,
        #       # /opt/google/chrome-stable/libwidevinecdmadapter.so mr,
        #       # /opt/google/chrome-stable/WidevineCdm/_platform_specific/linux_*/libwidevinecdm.so mr,

        #       # include if exists <local/chrome>
        #     }
        #   '';
        # };
      };
    };
  };
}
