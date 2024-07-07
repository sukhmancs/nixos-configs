{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.age) secrets;

  sys = config.modules.system;
  cfg = sys.services;
in {
  imports = [
    inputs.simple-nixos-mailserver.nixosModule
  ];

  config = {
    # required for roundcube
    networking.firewall.allowedTCPPorts = [80 443];

    mailserver = {
      enable = true;
      # mailDirectory = "/var/mail/vmail";
      # dkimKeyDirectory = "/var/mail/dkim";
      # sieveDirectory = "/var/mail/sieve";
      openFirewall = true;
      enableImap = true;
      enableImapSsl = true;
      enablePop3 = false;
      enablePop3Ssl = false;
      enableSubmission = false;
      enableSubmissionSsl = true;
      hierarchySeparator = "/";
      localDnsResolver = false;
      fqdn = "mail.xilain.dev";
      certificateScheme = "acme-nginx";
      domains = ["xilain.dev"];

      # To create the password hashes, use
      # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
      loginAccounts = {
        "shelf@xilain.dev" = {
          hashedPasswordFile = secrets.mailserver-secret.path;
          aliases = [
            "me"
            "shelf"
            "me@xilain.dev"
            "admin"
            "admin@xilain.dev"
            "root"
            "root@xilain.dev"
            "postmaster"
            "postmaster@xilain.dev"
          ];
        };

        "noreply@xilain.dev" = {
          aliases = ["noreply"];
          hashedPasswordFile = secrets.mailserver-noreply-secret.path;
          sendOnly = true;
          sendOnlyRejectMessage = "";
        };

        "git@xilain.dev" = mkIf cfg.forgejo.enable {
          aliases = ["git" "forgejo"];
          hashedPasswordFile = secrets.mailserver-forgejo-secret.path;
          sendOnly = true;
          sendOnlyRejectMessage = "";
        };

        "vaultwarden@xilain.dev" = mkIf cfg.vaultwarden.enable {
          aliases = ["vaultwarden" "vault"];
          hashedPasswordFile = secrets.mailserver-vaultwarden-secret.path;
          sendOnly = true;
          sendOnlyRejectMessage = "";
        };

        "matrix@xilain.dev" = mkIf cfg.social.matrix.enable {
          aliases = ["matrix"];
          hashedPasswordFile = secrets.mailserver-matrix-secret.path;
          sendOnly = true;
          sendOnlyRejectMessage = "";
        };

        "cloud@xilain.dev" = mkIf cfg.nextcloud.enable {
          aliases = ["cloud" "nextcloud"];
          hashedPasswordFile = secrets.mailserver-cloud-secret.path;
          sendOnly = true;
          sendOnlyRejectMessage = "";
        };

        "authelia@xilain.dev" = mkIf cfg.authelia.enable {
          aliases = ["auth" "security"];
          hashedPasswordFile = secrets.mailserver-authelia-secret.path;
          sendOnly = true;
          sendOnlyRejectMessage = "";
        };
      };

      mailboxes = {
        Archive = {
          auto = "subscribe";
          specialUse = "Archive";
        };
        Drafts = {
          auto = "subscribe";
          specialUse = "Drafts";
        };
        Sent = {
          auto = "subscribe";
          specialUse = "Sent";
        };
        Junk = {
          auto = "subscribe";
          specialUse = "Junk";
        };
        Trash = {
          auto = "subscribe";
          specialUse = "Trash";
        };
      };

      fullTextSearch = {
        enable = true;
        # index new email as they arrive
        autoIndex = true;
        # this only applies to plain text attachments, binary attachments are never indexed
        indexAttachments = true;
        enforced = "body";
      };

      vmailUserName = "vmail";
      vmailGroupName = "vmail";

      useFsLayout = true;
    };

    services = {
      roundcube = {
        enable = true;
        database.username = "roundcube";
        maxAttachmentSize = 50;
        dicts = with pkgs.aspellDicts; [en tr de];
        # this is the url of the vhost, not necessarily the same as the fqdn of
        # the mailserver
        hostName = "webmail.xilain.dev";
        extraConfig = ''
          $config['imap_host'] = array(
            'tls://mail.xilain.dev' => "xilain's Mail Server",
            'ssl://imap.gmail.com:993' => 'Google Mail',
          );
          $config['username_domain'] = array(
            'mail.xilain.dev' => 'xilain.dev',
            'mail.gmail.com' => 'gmail.com',
          );
          $config['x_frame_options'] = false;
          # starttls needed for authentication, so the fqdn required to match
          # the certificate
          $config['smtp_host'] = "tls://${config.mailserver.fqdn}";
          $config['smtp_user'] = "%u";
          $config['smtp_pass'] = "%p";
          $config['plugins'] = [ "carddav" ];
        '';
      };

      postfix = {
        dnsBlacklists = [
          "all.s5h.net"
          "b.barracudacentral.org"
          "bl.spamcop.net"
          "blacklist.woody.ch"
        ];
        dnsBlacklistOverrides = ''
          xilain.dev OK
          mail.xilain.dev OK
          127.0.0.0/8 OK
          192.168.0.0/16 OK
        '';
        headerChecks = [
          {
            action = "IGNORE";
            pattern = "/^User-Agent.*Roundcube Webmail/";
          }
        ];

        config = {
          smtp_helo_name = config.mailserver.fqdn;
        };
      };

      phpfpm.pools.roundcube.settings = {
        "listen.owner" = config.services.nginx.user;
        "listen.group" = config.services.nginx.group;
      };

      nginx.virtualHosts = {
        "mail.xilain.dev" = {quic = true;} // lib.sslTemplate;
        "webmail.xilain.dev" = {quic = true;} // lib.sslTemplate;
      };
    };
  };
}
