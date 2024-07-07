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
  "service/matrix.age".publicKeys = mkGlobal servers;
  "service/nextcloud.age".publicKeys = mkGlobal servers;
  # "service/mkm-web.age".publicKeys = mkGlobal servers;
  "service/vaultwarden.age".publicKeys = mkGlobal servers;
  "service/wg.age".publicKeys = mkGlobal servers;
  "service/searx.age".publicKeys = mkGlobal servers;
  "service/forgejo-runner-token.age".publicKeys = mkGlobal servers;
  "service/suwayomi-server.age".publicKeys = mkGlobal servers;
  "authelia/jwt_secret.age".publicKeys = mkGlobal servers;
  "authelia/session_secret.age".publicKeys = mkGlobal servers;
  "authelia/storage_encryption_key.age".publicKeys = mkGlobal servers;
  "authelia/postgre_password.age".publicKeys = mkGlobal servers;
  "authelia/lldap_user_pass.age".publicKeys = mkGlobal servers;
  "authelia/smtp_pass.age".publicKeys = mkGlobal servers;
  "lldap/jwt_secret.age".publicKeys = mkGlobal servers;
  "lldap/user_pass.age".publicKeys = mkGlobal servers;
  "lldap/private_key.age".publicKeys = mkGlobal servers;
  "lldap/key_seed.age".publicKeys = mkGlobal servers;
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
