let
  keys = import ../flake/keys.nix;
  inherit (keys) servers workstations;
  inherit (keys) mkGlobal;
in {
  # core system secrets
  # "common/nix-builder.age".publicKeys = mkGlobal (workstations ++ servers);
  # "client/spotify.age".publicKeys = mkGlobal workstations;
  "client/wg.age".publicKeys = mkGlobal (workstations ++ servers);
  "client/tailscale.age".publicKeys = mkGlobal (workstations ++ servers);
  "client/email.age".publicKeys = mkGlobal (workstations ++ servers);

  # service specific secrets
  "service/matrix.age".publicKeys = mkGlobal all;
  "service/nextcloud.age".publicKeys = mkGlobal all;
  # "service/mkm-web.age".publicKeys = mkGlobal servers;
  "service/vaultwarden.age".publicKeys = mkGlobal all;
  "service/wg.age".publicKeys = mkGlobal all;
  "service/searx.age".publicKeys = mkGlobal all;
  "service/forgejo-runner-token.age".publicKeys = mkGlobal all;
  "service/suwayomi-server.age".publicKeys = mkGlobal all;
  "authelia/jwt_secret.age".publicKeys = mkGlobal all;
  "authelia/session_secret.age".publicKeys = mkGlobal all;
  "authelia/storage_encryption_key.age".publicKeys = mkGlobal all;
  "authelia/postgre_password.age".publicKeys = mkGlobal all;
  "authelia/lldap_user_pass.age".publicKeys = mkGlobal all;
  "authelia/smtp_pass.age".publicKeys = mkGlobal all;
  "lldap/jwt_secret.age".publicKeys = mkGlobal all;
  "lldap/user_pass.age".publicKeys = mkGlobal all;
  "lldap/private_key.age".publicKeys = mkGlobal all;
  "lldap/key_seed.age".publicKeys = mkGlobal all;
  # "service/forgejo-runner-config.age".publicKeys = mkGlobal servers;
  "service/harmonia.age".publicKeys = mkGlobal servers;
  "service/attic.age".publicKeys = mkGlobal servers;
  "service/github_notification_token.age".publicKeys = mkGlobal servers;
  # "service/headscale-noise.age".publicKeys = mkGlobal servers;
  # "service/headscale-derp.age".publicKeys = mkGlobal servers;

  "db/mongodb.age".publicKeys = mkGlobal servers;
  "db/garage.age".publicKeys = mkGlobal servers;

  # secrets for specific mailserver accounts
  "mailserver/cloud.age".publicKeys = mkGlobal servers;
  "mailserver/forgejo.age".publicKeys = mkGlobal servers;
  "mailserver/matrix.age".publicKeys = mkGlobal servers;
  "mailserver/noreply.age".publicKeys = mkGlobal servers;
  "mailserver/postmaster.age".publicKeys = mkGlobal servers;
  "mailserver/vaultwarden.age".publicKeys = mkGlobal servers;
  "mailserver/authelia.age".publicKeys = mkGlobal servers;
}
