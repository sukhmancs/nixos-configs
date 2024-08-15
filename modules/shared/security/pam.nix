{
  security = {
    pam = {
      # Increase the number of open files for users in the wheel group.
      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
        { # By setting this limit, you are configuring the system to prevent
          # the creation of core dump files for all users. This is a security
          # measure to prevent sensitive information from being written to disk in
          # the event of a program crash.
          domain = "*";
          item = "core";
          type = "hard";
          value = "0";
        }
      ];

      services = {
        # Increase hashing rounds for /etc/shadow; this doesn't automatically
        # rehash your passwords, you'll need to set passwords for your accounts
        # again for this to work.
        passwd.text = ''
          password required pam_unix.so sha512 shadow nullok rounds=65536
        '';
        # Enable PAM support for securetty, to prevent root login.
        # https://unix.stackexchange.com/questions/670116/debian-bullseye-disable-console-tty-login-for-root
        login.text = l.mkDefault (
          l.mkBefore ''
            # Enable securetty support.
            auth       requisite  pam_nologin.so
            auth       requisite  pam_securetty.so
          ''
        );

        su.requireWheel = true;
        su-l.requireWheel = true;
        system-login.failDelay.delay = "4000000";

        # allow screen lockers to also unlock the screen
        # (e.g. swaylock, gtklock)
        swaylock.text = "auth include login";
        gtklock.text = "auth include login";
      };
    };
  };
}
