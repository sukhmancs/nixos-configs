{
  config,
  lib,
  ...
}: let
  inherit (lib) mkAgenixSecret;
  inherit (lib.strings) optionalString;

  autheliaUser =
    if ((config ? services.authelia.instances.main) && config.services.authelia.instances.main.enable)
    then config.services.authelia.instances.main.user
    else "";

  sys = config.modules;
  cfg = sys.services;
in {
  users = {
    groups = {
      lldap-secrets = {};
      gitea-secrets = {};

      miniflux-secrets = {};
    };
  };

  age.identityPaths = [
    "${optionalString sys.system.impermanence.root.enable "/persist"}/etc/ssh/ssh_host_ed25519_key"
    "${optionalString sys.system.impermanence.home.enable "/persist"}/home/notashelf/.ssh/id_ed25519"
  ];

  age.secrets = {
    # TODO: system option for declaring host as a potential builder
    nix-builderKey = mkAgenixSecret true {
      file = "common/nix-builder.age";
    };

    tailscale-client = mkAgenixSecret true {
      file = "client/tailscale.age";
      owner = "notashelf";
      group = "users";
      mode = "400";
    };

    # secrets needed for peers
    spotify-secret = mkAgenixSecret true {
      file = "client/spotify.age";
      owner = "notashelf";
      group = "users";
      mode = "400";
    };

    wg-client = mkAgenixSecret true {
      file = "client/wg.age";
      owner = "notashelf";
      group = "users";
      mode = "700";
    };

    client-email = mkAgenixSecret true {
      file = "client/email.age";
      owner = "notashelf";
      group = "users";
      mode = "400";
    };

    # database secrets
    mongodb-secret = mkAgenixSecret false {
      file = "db/mongodb.age";
    };

    garage-env = mkAgenixSecret false {
      file = "db/garage.age";
      mode = "400";
      owner = "garage";
      group = "garage";
    };

    # service secrets
    wg-server = mkAgenixSecret true {
      file = "service/wg.age";
    };

    mkm-web = mkAgenixSecret false {
      file = "service/mkm-web.age";
      mode = "400";
    };

    github_notification_token = mkAgenixSecret true {
      file = "service/github_notification_token.age";
    };

    matrix-secret = mkAgenixSecret true {
      file = "service/matrix.age";
      owner = "matrix-synapse";
      mode = "440";
    };

    vaultwarden-env = mkAgenixSecret true {
      file = "service/vaultwarden.age";
      owner = "vaultwarden";
      mode = "440";
    };

    searx-secretkey = mkAgenixSecret config.services.searx.enable {
      file = "service/searx.age";
      mode = "440";
      owner = "searx";
      group = "searx";
    };

    nextcloud-secret = mkAgenixSecret true {
      file = "service/nextcloud.age";
      mode = "400";
      owner = "nextcloud";
      group = "nextcloud";
    };

    attic-env = mkAgenixSecret false {
      file = "service/attic.age";
      mode = "400";
      owner = "atticd";
      group = "atticd";
    };

    harmonia-privateKey = mkAgenixSecret true {
      file = "service/harmonia.age";
      mode = "770";
      owner = "harmonia";
      group = "harmonia";
    };

    forgejo-runner-token = mkAgenixSecret false {
      file = "service/forgejo-runner-token.age";
      mode = "440";
      owner = "gitea-runner";
      group = "gitea-runner";
    };

    forgejo-runner-config = mkAgenixSecret false {
      file = "service/forgejo-runner-config.age";
      mode = "440";
      owner = "gitea-runner";
      group = "gitea-runner";
    };

    headscale-derp = mkAgenixSecret true {
      file = "service/headscale-derp.age";
      mode = "400";
      owner = "headscale";
      group = "headscale";
    };

    headscale-noise = mkAgenixSecret true {
      file = "service/headscale-noise.age";
      mode = "400";
      owner = "headscale";
      group = "headscale";
    };

    suwayomi-server-password = mkAgenixSecret config.services.suwayomi-server.enable {
      file = "service/suwayomi-server.age";
      mode = "440";
      owner = "suwayomi";
      group = "suwayomi";
    };

    #TODO: authelia secrets are being enabled when lldap is enabled
    # fix this by making authelia secrets depend on authelia being enabled
    # This is just a temporary fix
    # authelia secrets
    authelia_jwt_secret = mkAgenixSecret ((config ? services.authelia.instances.main)
      && config.services.authelia.instances.main.enable) {
      file = "authelia/jwt_secret.age";
      owner = autheliaUser;
    };

    authelia_session_secret = mkAgenixSecret ((config ? services.authelia.instances.main)
      && config.services.authelia.instances.main.enable) {
      file = "authelia/session_secret.age";
      owner = autheliaUser;
    };

    authelia_storage_encryption_key = mkAgenixSecret ((config ? services.authelia.instances.main)
      && config.services.authelia.instances.main.enable) {
      file = "authelia/storage_encryption_key.age";
      owner = autheliaUser;
    };

    authelia_postgre_password = mkAgenixSecret ((config ? services.authelia.instances.main)
      && config.services.authelia.instances.main.enable) {
      file = "authelia/postgre_password.age";
      owner = autheliaUser;
    };

    authelia_smtp_password = mkAgenixSecret ((config ? services.authelia.instances.main)
      && config.services.authelia.instances.main.enable) {
      file = "authelia/smtp_pass.age";
      owner = autheliaUser;
    };

    # lldap secrets
    lldap_jwt_secret = mkAgenixSecret config.services.lldap.enable {
      file = "lldap/jwt_secret.age";
      mode = "440";
      group = "lldap-secrets";
    };

    lldap_user_pass = mkAgenixSecret config.services.lldap.enable {
      file = "lldap/user_pass.age";
      mode = "440";
      owner = autheliaUser;
      group = "lldap-secrets";
    };

    lldap_private_key = mkAgenixSecret config.services.lldap.enable {
      file = "lldap/private_key.age";
      mode = "440";
      group = "lldap-secrets";
    };

    lldap_key_seed = mkAgenixSecret config.services.lldap.enable {
      file = "lldap/key_seed.age";
      mode = "440";
      group = "lldap-secrets";
    };

    # mailserver secrets
    mailserver-secret = mkAgenixSecret true {
      file = "mailserver/postmaster.age";
      mode = "400";
    };

    mailserver-forgejo-secret = mkAgenixSecret true {
      file = "mailserver/forgejo.age";
      owner = "forgejo";
      group = "forgejo";
      mode = "440";
    };

    mailserver-vaultwarden-secret = mkAgenixSecret true {
      file = "mailserver/vaultwarden.age";
      owner = "vaultwarden";
      mode = "400";
    };

    mailserver-cloud-secret = mkAgenixSecret true {
      file = "mailserver/cloud.age";
      owner = "nextcloud";
      mode = "400";
    };

    mailserver-matrix-secret = mkAgenixSecret true {
      file = "mailserver/matrix.age";
      owner = "matrix-synapse";
      mode = "400";
    };

    mailserver-noreply-secret = mkAgenixSecret true {
      file = "mailserver/noreply.age";
      owner = "mastodon";
      mode = "400";
    };

    mailserver-authelia-secret = mkAgenixSecret ((config ? services.authelia.instances.main)
      && config.services.authelia.instances.main.enable) {
      file = "mailserver/authelia.age";
      owner = autheliaUser;
    };
  };
}
