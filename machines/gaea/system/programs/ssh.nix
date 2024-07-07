{
  keys,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkForce mkDefault;
  inherit (lib.strings) concatStringsSep;
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.lists) elemAt;
in {
  services = {
    openssh = {
      # enable openssh
      enable = true;
      openFirewall = true; # the ssh port(s) should be automatically passed to the firewall's allowedTCPports
      ports = [30]; # the port(s) openssh daemon should listen on
      startWhenNeeded = true; # automatically start the ssh daemon when it's required
      settings = {
        # no root login
        PermitRootLogin = mkForce "yes"; # not the best thing to do

        # no password auth
        # force publickey authentication only
        PasswordAuthentication = false;
        AuthenticationMethods = "publickey";
        PubkeyAuthentication = "yes";
        ChallengeResponseAuthentication = "no";
        UsePAM = false;

        # remove sockets as they get stale
        # this will unbind gnupg sockets if they exists
        StreamLocalBindUnlink = "yes";

        KbdInteractiveAuthentication = mkDefault false;
        UseDns = false; # no
        X11Forwarding = false; # ew xorg

        # key exchange algorithms recommended by `nixpkgs#ssh-audit`
        KexAlgorithms = [
          "curve25519-sha256"
          "curve25519-sha256@libssh.org"
          "diffie-hellman-group16-sha512"
          "diffie-hellman-group18-sha512"
          "diffie-hellman-group-exchange-sha256"
          "sntrup761x25519-sha512@openssh.com"
        ];

        # message authentication code algorithms recommended by `nixpkgs#ssh-audit`
        Macs = [
          "hmac-sha2-512-etm@openssh.com"
          "hmac-sha2-256-etm@openssh.com"
          "umac-128-etm@openssh.com"
        ];

        # kick out inactive sessions
        ClientAliveCountMax = 5;
        ClientAliveInterval = 60;

        # max auth attempts
        MaxAuthTries = 3;
      };

      hostKeys = mkDefault [
        {
          bits = 4096;
          path = "/etc/ssh/ssh_host_rsa_key";
          type = "rsa";
        }
        {
          bits = 4096;
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };
    fail2ban.jails = {
      # sshd jail
      sshd = {
        settings = {
          enabled = true;
          filter = "sshd[mode=aggressive]";
          port = concatStringsSep "," (map toString config.services.openssh.ports);
        };
      };
    };
  };
}
