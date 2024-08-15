{pkgs, lib, ...}:
let
l = lib // builtins;
  sources = l.fromTOML (l.readFile ./sources.toml);

  fetchGhFile =
    {
      user,
      repo,
      rev,
      file,
      sha256,
      ...
    }:
    builtins.fetchurl {
      url = "https://raw.githubusercontent.com/${user}/${repo}/${rev}/${file}";
      inherit sha256;
    };
in {
  environment.etc = {
    # Empty /etc/securetty to prevent root login on tty.
    securetty.text = ''
      # /etc/securetty: list of terminals on which root is allowed to login.
      # See securetty(5) and login(1).
    '';

    # Set machine-id to the Kicksecure machine-id, for privacy reasons.
    # /var/lib/dbus/machine-id doesn't exist on dbus enabled NixOS systems,
    # so we don't have to worry about that.
    machine-id.text = ''
      b08dfa6083e7567a1921a715000001fb
    '';

    # Borrow Kicksecure banner/issue.
    issue.source = fetchGhFile sources.issue;

    # Borrow Kicksecure gitconfig, disabling git symlinks and enabling fsck
    # by default for better git security.
    gitconfig.source = fetchGhFile sources.gitconfig;

    # Borrow Kicksecure bluetooth configuration for better bluetooth privacy
    # and security. Disables bluetooth automatically when not connected to
    # any device.
    "bluetooth/main.conf".source = l.mkForce (fetchGhFile sources.bluetooth);

    # Borrow Kicksecure and secureblue module blacklist.
    # "install "foobar" /bin/not-existent" prevents the module from being
    # loaded at all. "blacklist "foobar"" prevents the module from being
    # loaded automatically at boot, but it can still be loaded afterwards.
    "modprobe.d/nm-module-blacklist.conf".source = fetchGhFile sources.module-blacklist;
  };

  # Don't store coredumps from systemd-coredump.
  systemd.coredump.extraConfig = l.mkDefault ''
    Storage=none
  '';

  systemd.tmpfiles.settings = {
    # Restrict permissions of /home/$USER so that only the owner of the
    # directory can access it (the user). systemd-tmpfiles also has the benefit
    # of recursively setting permissions too, with the "Z" option as seen below.
    "restricthome"."/home/*".Z.mode = "0700";

    # Make all files in /etc/nixos owned by root, and only readable by root.
    # /etc/nixos is not owned by root by default, and configuration files can
    # on occasion end up also not owned by root. This can be hazardous as files
    # that are included in the rebuild may be editable by unprivileged users,
    # so this mitigates that.
    "restrictetcnixos"."/etc/nixos/*".Z = {
      mode = "0000";
      user = "root";
      group = "root";
    };
  };
}