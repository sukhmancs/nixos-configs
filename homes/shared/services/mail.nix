{
  osConfig,
  config,
  pkgs,
  ...
}: {
  config = let
    extraMailboxes = ["Archive" "Drafts" "Junk" "Sent" "Trash"];
  in {
    accounts.email = {
      maildirBasePath = config.xdg.userDirs.extraConfig.XDG_MAIL_DIR;
      accounts = {
        xi = let
          gpgKey = "0xBA46BCC36E912922";
          name = "XiLain";
        in {
          primary = true;
          address = "shelf@xilain.dev";
          aliases = ["me@xilain.dev"];
          userName = "shelf@xilain.dev";
          realName = name;
          passwordCommand = ''
            # this is a really bad way of getting the password
            # but home-manager does not provide a passwordFile option
            tail ${osConfig.age.secrets.client-email.path} -n 1
          '';

          signature = {
            showSignature = "append";
            text = ''
              --
              ${name}

              Want to use GPG encryption? Try my GPG key:
              [${gpgKey}](https://raw.githubusercontent.com/sukhmancs/sukhmancs.gpg/master/public.pgp)
            '';
          };

          folders = {
            inbox = "Inbox";
            drafts = "Drafts";
            sent = "Sent";
            trash = "Trash";
          };

          imap = {
            host = "xilain.dev";
            tls.enable = true;
          };

          smtp = {
            host = "xilain.dev";
            tls.enable = true;
          };

          gpg = {
            key = gpgKey;
            signByDefault = true;
          };

          msmtp.enable = true;
          mbsync = {
            enable = true;
            create = "maildir"; # funny as it is, this is not a path - it's an instruction
            expunge = "both";
          };

          neomutt = {
            enable = true;
            inherit extraMailboxes;
          };
        };
      };
    };

    systemd.user = {
      timers."mbsync" = {
        Unit.Description = "Automatic mbsync synchronization";
        Timer = {
          OnBootSec = "30";
          OnUnitActiveSec = "5m";
        };
        Install.WantedBy = ["timers.target"];
      };

      services."genFolders" = {
        Unit.Description = "Generate folders for email accounts";
        Install.WantedBy = ["multi-user.target"];
        Service = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = let
            script = pkgs.writeShellApplication {
              name = "genFolders";
              text = ''
                # move to the current user's home directory
                # FIXME: pretty sure this can also be set as the service's runtime dir
                cd "${config.home.homeDirectory}/Mail"

                # iterate over dirs and create those that do not exist
                for dir in ${toString extraMailboxes}; do
                  if [ ! -d "$dir" ]; then
                    echo -en "$dir does not exist, creating...\n";
                    mkdir "$dir"
                    echo "Done creating $dir"
                  fi
                done
              '';
            };
          in "${script}/bin/genFolders";

          # set runtime dir to the current user's home directory
        };
      };
    };
  };
}
